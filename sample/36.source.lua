_G.scw = 0
function scA()
    _G.scw = _G.scw + 1
    print("A", _G.scw)
    return _G.scw < 4
end
function scB()
    print("B", _G.scw)
    return _G.scw % 2 == 0
end
function scC()
    print("C", _G.scw)
    return true
end
while scA() and (scB() or scC()) do
    print("short-while-body", _G.scw)
end
_G.scr = 0
function srA()
    _G.scr = _G.scr + 1
    print("RA", _G.scr)
    return _G.scr >= 3
end
function srB()
    print("RB", _G.scr)
    return _G.scr % 2 == 1
end
function srC()
    print("RC", _G.scr)
    return false
end
repeat
    print("short-repeat-body", _G.scr)
until srA() and srB() or srC()
print("short-end", _G.scw, _G.scr)
