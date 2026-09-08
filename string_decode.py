#!/usr/bin/env python3
"""
Decode this Lua string-encryption family without removing or rewriting any
surrounding runtime logic.

Usage:
    python string_decoder.py input.lua [input2.lua ...]

Each input is written as <name>.decoded.lua beside the source file.

The tool auto-detects:
- the cache proxy table,
- the decoder function,
- the LCG constants,
- the 257-modulo multiplier,
- the rolling-byte accumulator.

Only expressions shaped like:
    cache[decoder("encrypted", numeric_seed)]
are replaced, and every replacement is parenthesized:
    ("decoded")

This keeps chained calls safe:
    cache[decoder(...)]:find("x")
becomes:
    ("decoded"):find("x")
"""

from pathlib import Path
import argparse
import math
import re


def parse_lua_quoted(literal: str) -> bytes:
    if len(literal) < 2 or literal[0] != literal[-1] or literal[0] not in "\"'":
        raise ValueError("Expected a quoted Lua string literal")

    out = bytearray()
    i = 1
    end = len(literal) - 1
    simple = {
        "a": 7, "b": 8, "f": 12, "n": 10, "r": 13,
        "t": 9, "v": 11, "\\": 92, '"': 34, "'": 39,
    }

    while i < end:
        ch = literal[i]
        if ch != "\\":
            out.extend(ch.encode("utf-8"))
            i += 1
            continue

        i += 1
        if i >= end:
            raise ValueError("Dangling Lua escape")

        ch = literal[i]
        if ch in simple:
            out.append(simple[ch])
            i += 1
        elif ch.isdigit():
            j = i
            while j < end and j < i + 3 and literal[j].isdigit():
                j += 1
            value = int(literal[i:j])
            if value > 255:
                raise ValueError(f"Invalid Lua decimal escape: {value}")
            out.append(value)
            i = j
        elif ch == "x":
            if i + 2 >= end:
                raise ValueError("Incomplete Lua hex escape")
            out.append(int(literal[i + 1:i + 3], 16))
            i += 3
        elif ch == "z":
            i += 1
            while i < end and literal[i].isspace():
                i += 1
        elif ch == "\n":
            out.append(10)
            i += 1
        elif ch == "\r":
            out.append(10)
            i += 1
            if i < end and literal[i] == "\n":
                i += 1
        else:
            out.extend(ch.encode("utf-8"))
            i += 1

    return bytes(out)


def lua_string_literal(data: bytes) -> str:
    try:
        text = data.decode("utf-8")
    except UnicodeDecodeError:
        text = None

    if text is not None:
        parts = ['"']
        for ch in text:
            code = ord(ch)
            if ch == "\\":
                parts.append("\\\\")
            elif ch == '"':
                parts.append('\\"')
            elif ch == "\n":
                parts.append("\\n")
            elif ch == "\r":
                parts.append("\\r")
            elif ch == "\t":
                parts.append("\\t")
            elif ch == "\b":
                parts.append("\\b")
            elif ch == "\f":
                parts.append("\\f")
            elif ch == "\v":
                parts.append("\\v")
            elif code == 7:
                parts.append("\\a")
            elif code < 32 or code == 127:
                parts.append(f"\\{code:03d}")
            else:
                parts.append(ch)
        parts.append('"')
        return "".join(parts)

    parts = ['"']
    for b in data:
        if b == 92:
            parts.append("\\\\")
        elif b == 34:
            parts.append('\\"')
        elif b == 10:
            parts.append("\\n")
        elif b == 13:
            parts.append("\\r")
        elif b == 9:
            parts.append("\\t")
        elif 32 <= b <= 126:
            parts.append(chr(b))
        else:
            parts.append(f"\\{b:03d}")
    parts.append('"')
    return "".join(parts)


def extract_decoder_config(source: str) -> dict:
    proxy_match = re.search(
        r"(?m)^\s*(?:local\s+)?(\w+)\s*=\s*setmetatable\(\s*\{\s*\}\s*,\s*"
        r"\{\s*__index\s*=\s*(\w+)",
        source,
    )
    if not proxy_match:
        raise ValueError("Could not locate decoder cache proxy")

    proxy = proxy_match.group(1)
    after_proxy = proxy_match.end()

    decoder_match = re.search(
        r"(?m)^\s*(?:local\s+)?(\w+)\s*=\s*function\s*\(([^)]*)\)",
        source[after_proxy:],
    )
    if not decoder_match:
        raise ValueError("Could not locate decoder function")

    decoder = decoder_match.group(1)

    lcg_match = re.search(
        r"=\s*\(\(\(\w+\s*\*\s*(\d+)\)\s*\+\s*(\d+)\)\s*%\s*(35184372088832)\)",
        source,
    )
    if not lcg_match:
        raise ValueError("Could not locate decoder LCG constants")

    factor_match = re.search(
        r"=\s*\(\(\w+\s*\*\s*(\d+)\)\s*%\s*257\)",
        source,
    )
    if not factor_match:
        raise ValueError("Could not locate decoder multiplier")

    decoder_start = after_proxy + decoder_match.start()
    decoder_window = source[decoder_start:decoder_start + 3000]
    accumulator_match = re.search(
        r"local\s+\w+\s*=\s*(\d+)\s*"
        r"for\s+\w+\s*=\s*1\s*,\s*\w+\s*do\s*"
        r"\w+\s*=\s*\(\(\(string\.byte",
        decoder_window,
        re.S,
    )
    if not accumulator_match:
        raise ValueError("Could not locate decoder accumulator")

    return {
        "proxy": proxy,
        "decoder": decoder,
        "mul": int(lcg_match.group(1)),
        "add": int(lcg_match.group(2)),
        "modulus": int(lcg_match.group(3)),
        "factor": int(factor_match.group(1)),
        "accumulator": int(accumulator_match.group(1)),
    }


def keystream(seed: int, cfg: dict):
    state = seed % cfg["modulus"]
    counter = (seed % 255) + 2
    buffer = []

    while True:
        if not buffer:
            state = ((state * cfg["mul"]) + cfg["add"]) % cfg["modulus"]

            while True:
                counter = (counter * cfg["factor"]) % 257
                if counter != 1:
                    break

            low5 = counter % 32
            mixed = (
                math.floor(
                    state / (2 ** (13 - ((counter - low5) / 32)))
                ) % 4294967296
            ) / (2 ** low5)

            packed = (
                math.floor((mixed % 1) * 4294967296)
                + math.floor(mixed)
            )

            low16 = packed % 65536
            high16 = (packed - low16) // 65536
            b1 = low16 % 256
            b2 = (low16 - b1) // 256
            b3 = high16 % 256
            b4 = (high16 - b3) // 256
            buffer = [b1, b2, b3, b4]

        yield int(buffer.pop())


def decode_ciphertext(ciphertext: bytes, seed: int, cfg: dict) -> bytes:
    stream = keystream(seed, cfg)
    rolling = cfg["accumulator"]
    output = bytearray()

    for byte in ciphertext:
        rolling = (byte + next(stream) + rolling) % 256
        output.append(rolling)

    return bytes(output)


STRING_LITERAL = r'(?P<string>"(?:\\.|[^"\\])*"|\'(?:\\.|[^\'\\])*\')'


def decode_source(source: str):
    cfg = extract_decoder_config(source)
    pattern = re.compile(
        re.escape(cfg["proxy"])
        + r"\s*\[\s*"
        + re.escape(cfg["decoder"])
        + r"\s*\(\s*"
        + STRING_LITERAL
        + r"\s*,\s*(?P<seed>\d+)\s*\)\s*\]"
    )

    matches = list(pattern.finditer(source))
    if not matches:
        raise ValueError("No encrypted string expressions found")

    seen = {}
    for match in matches:
        seed = int(match.group("seed"))
        encrypted = parse_lua_quoted(match.group("string"))
        old = seen.get(seed)
        if old is not None and old != encrypted:
            raise ValueError(
                f"Ambiguous decoder cache key {seed}: multiple ciphertexts found"
            )
        seen[seed] = encrypted

    def replace(match):
        encrypted = parse_lua_quoted(match.group("string"))
        seed = int(match.group("seed"))
        plaintext = decode_ciphertext(encrypted, seed, cfg)
        return f"({lua_string_literal(plaintext)})"

    decoded, count = pattern.subn(replace, source)

    if pattern.search(decoded):
        raise AssertionError("Encrypted expression remained after replacement")
    if source.count("\n") != decoded.count("\n"):
        raise AssertionError("Line count changed unexpectedly")

    return decoded, cfg, count, len(seen)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("files", nargs="+", type=Path)
    args = parser.parse_args()

    for src in args.files:
        source = src.read_text(encoding="utf-8")
        decoded, cfg, count, unique = decode_source(source)
        dst = src.with_name(src.stem + ".decoded.lua")
        dst.write_text(decoded, encoding="utf-8", newline="")
        print(
            f"{src} -> {dst} | replaced={count} | unique_keys={unique} | "
            f"shape={cfg['proxy']}[{cfg['decoder']}(...)]"
        )


if __name__ == "__main__":
    main()
