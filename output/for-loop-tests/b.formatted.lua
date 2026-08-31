return (function(...)
    local z = {
        "gGybWDL=",
        "Ou+7Psn=",
        "XsJeps4V",
        "Ou+Dpe==",
        "Ou+bWiIkdm==",
        "KU+Mqi2uqHb0qD9VpDB="
    }
    local function D(D)
        return z[D - (6770)]
    end
    for D, U in ipairs({
        {
            1,
            6
        },
        {
            1,
            4
        },
        {
            5,
            6
        }
    }) do
        while U[1] < U[2] do
            z[U[1]], z[U[2]], U[1], U[2] = z[U[2]], z[U[1]], U[1] + (1), U[2] - (1)
        end
    end
    do
        local D = {
            ["5"] = 36,
            ["3"] = 47,
            i = 38,
            x = 31,
            Q = 45,
            T = 42,
            s = 22,
            l = 6,
            j = 10,
            ["2"] = 40,
            G = 7,
            t = 49,
            I = 17,
            n = 56,
            W = 27,
            D = 39,
            q = 19,
            y = 9,
            c = 60,
            b = 41,
            r = 18,
            O = 23,
            z = 35,
            e = 48,
            Z = 58,
            ["0"] = 14,
            p = 24,
            ["/"] = 26,
            R = 11,
            X = 29,
            A = 62,
            N = 63,
            h = 46,
            ["1"] = 55,
            Y = 3,
            L = 16,
            ["6"] = 33,
            V = 43,
            M = 15,
            f = 12,
            ["9"] = 1,
            C = 2,
            w = 8,
            B = 20,
            v = 5,
            E = 51,
            d = 30,
            P = 25,
            ["+"] = 61,
            o = 34,
            m = 0,
            S = 32,
            H = 4,
            ["7"] = 44,
            a = 50,
            K = 21,
            U = 54,
            k = 37,
            u = 53,
            ["8"] = 59,
            ["4"] = 13,
            F = 52,
            g = 28,
            J = 57
        }
        local U = z
        local a = type
        local S = string.sub
        local I = string.len
        local x = table.insert
        local l = math.floor
        local n = table.concat
        local R = string.char
        for z = 1, #U, 1 do
            local e = U[z]
            if a(e) == "string" then
                local a = I(e)
                local X = {}
                local A = 1
                local W = 0
                local N = 0
                while A <= a do
                    local z = S(e, A, A)
                    local U = D[z]
                    if U then
                        W = W + U * (64) ^ ((3) - N)
                        N = N + (1)
                        if N == 4 then
                            N = 0
                            local z = l(W / (65536))
                            local D = l((W % (65536)) / (256))
                            local U = W % (256)
                            x(X, R(z, D, U))
                            W = 0
                        end
                    elseif z == "=" then
                        x(X, R(l(W / (65536))))
                        if A >= a or S(e, A + (1), A + (1)) ~= "=" then
                            x(X, R(l((W % (65536)) / (256))))
                        end
                        break
                    end
                    A = A + (1)
                end
                U[z] = n(X)
            end
        end
    end
    return (function(z, a, S, I, x, l, n, U, R, O, A, W, N, i, X, e)
        e, X, A, N, U, W, R, O, i = {}, function()
            A = A + (1)
            e[A] = 1
            return A
        end, 0, function(z)
            local D, U = 1, z[1]
            while U do
                e[U], D = e[U] - (1), (1) + D
                if 0 == e[U] then
                    e[U], R[U] = nil, nil
                end
                U = z[D]
            end
        end, function(U, S, I, x)
            local N, n, W, X, R, A, e
            while U do
                if U < 8702923 then
                    if U < 7624033 then
                        e = e + A
                        N = not W
                        n = e <= X
                        n = N and n
                        N = e >= X
                        N = W and N
                        n = N or n
                        N = 8130201
                        U = n and N
                        n = 12738267
                        U = U or n
                    else
                        n = D(6775)
                        N = e
                        U = z[n]
                        n = U(N)
                        N = nil
                        U = 6901613
                    end
                else
                    if U < 11127327 then
                        n = 1
                        e = 2
                        X = e
                        R = S
                        U = 6901613
                        e = 2
                        A = e
                        e = 0
                        W = A < e
                        e = n - A
                    else
                        U = z[D(6774)]
                        n = {}
                    end
                end
            end
            U = #x
            return a(n)
        end, function(z)
            for D = 1, #z, 1 do
                e[z[D]] = e[z[D]] + (1)
            end
            if S then
                local U = S(true)
                local a = x(U)
                a[D(6773)], a[D(6772)], a[D(6776)] = z, N, function()
                    return 3582028
                end
                return U
            else
                return I({}, {
                    [D(6772)] = N,
                    [D(6773)] = z,
                    [D(6776)] = function()
                        return 3582028
                    end
                })
            end
        end, {}, function(z)
            e[z] = e[z] - (1)
            if 0 == e[z] then
                e[z], R[z] = nil, nil
            end
        end, function(z, D)
            local a = W(D)
            local S = function(...)
                return U(z, {
                    ...
                }, D, a)
            end
            return S
        end
        return (i(10774943, {}))(a(n))
    end)(getfenv and getfenv() or _ENV, unpack or table[D(6771)], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)