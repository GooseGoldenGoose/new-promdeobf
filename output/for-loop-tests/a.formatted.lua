return (function(...)
    local Y = {
        "etUYMoX=",
        "A7b2ZBw=",
        "A7bYM6OijP==",
        "FtFiWiUp0IUGj0Uz",
        "A7boWJ==",
        "SByJWBFT"
    }
    local function v(v)
        return Y[v + (54291)]
    end
    for v, C in ipairs({
        {
            1,
            6
        },
        {
            1,
            2
        },
        {
            3,
            6
        }
    }) do
        while C[1] < C[2] do
            Y[C[1]], Y[C[2]], C[1], C[2] = Y[C[2]], Y[C[1]], C[1] + (1), C[2] - (1)
        end
    end
    do
        local v = {
            ["3"] = 14,
            P = 0,
            ["1"] = 50,
            U = 9,
            F = 13,
            u = 46,
            e = 28,
            z = 34,
            ["5"] = 47,
            Z = 25,
            I = 36,
            R = 21,
            q = 49,
            s = 62,
            k = 63,
            f = 45,
            l = 12,
            X = 16,
            L = 35,
            n = 32,
            A = 23,
            D = 54,
            ["0"] = 19,
            S = 29,
            ["+"] = 42,
            ["6"] = 38,
            Q = 15,
            ["7"] = 53,
            ["2"] = 44,
            J = 48,
            ["4"] = 4,
            W = 24,
            B = 22,
            o = 39,
            t = 7,
            ["8"] = 1,
            b = 61,
            h = 26,
            p = 2,
            E = 10,
            j = 30,
            V = 52,
            c = 31,
            ["9"] = 60,
            K = 11,
            T = 43,
            a = 33,
            v = 8,
            m = 18,
            x = 58,
            N = 51,
            ["/"] = 59,
            Y = 41,
            w = 56,
            O = 17,
            H = 5,
            M = 27,
            i = 37,
            y = 57,
            r = 3,
            C = 40,
            g = 20,
            G = 55,
            d = 6
        }
        local C = Y
        local P = type
        local T = math.floor
        local F = table.insert
        local t = string.len
        local w = string.sub
        local X = string.char
        local r = table.concat
        for Y = 1, #C, 1 do
            local g = C[Y]
            if P(g) == "string" then
                local P = t(g)
                local W = {}
                local c = 1
                local O = 0
                local h = 0
                while c <= P do
                    local Y = w(g, c, c)
                    local C = v[Y]
                    if C then
                        O = O + C * (64) ^ ((3) - h)
                        h = h + (1)
                        if h == 4 then
                            h = 0
                            local Y = T(O / (65536))
                            local v = T((O % (65536)) / (256))
                            local C = O % (256)
                            F(W, X(Y, v, C))
                            O = 0
                        end
                    elseif Y == "=" then
                        F(W, X(T(O / (65536))))
                        if c >= P or w(g, c + (1), c + (1)) ~= "=" then
                            F(W, X(T((O % (65536)) / (256))))
                        end
                        break
                    end
                    c = c + (1)
                end
                C[Y] = r(W)
            end
        end
    end
    return (function(Y, P, T, F, t, w, X, h, d, g, W, O, C, c, r, o)
        d, r, W, O, o, h, c, C, g = function(Y)
            g[Y] = g[Y] - (1)
            if 0 == g[Y] then
                g[Y], r[Y] = nil, nil
            end
        end, {}, function()
            c = c + (1)
            g[c] = 1
            return c
        end, function(Y)
            for v = 1, #Y, 1 do
                g[Y[v]] = g[Y[v]] + (1)
            end
            if T then
                local C = T(true)
                local P = t(C)
                P[v(-54286)], P[v(-54290)], P[v(-54287)] = Y, h, function()
                    return -588774
                end
                return C
            else
                return F({}, {
                    [v(-54290)] = h,
                    [v(-54286)] = Y,
                    [v(-54287)] = function()
                        return -588774
                    end
                })
            end
        end, function(Y, v)
            local P = O(v)
            local T = function(...)
                return C(Y, {
                    ...
                }, v, P)
            end
            return T
        end, function(Y)
            local v, C = 1, Y[1]
            while C do
                g[C], v = g[C] - (1), (1) + v
                if g[C] == 0 then
                    g[C], r[C] = nil, nil
                end
                C = Y[v]
            end
        end, 0, function(C, T, F, t)
            local r, O, h, X, g, c, W
            while C do
                if C < 9591098 then
                    if C < 1385309 then
                        C = Y[v(-54285)]
                        X = {}
                    else
                        g = g + c
                        X = g <= W
                        h = not O
                        X = h and X
                        h = g >= W
                        h = O and h
                        X = h or X
                        h = 16687615
                        C = X and h
                        X = 1088967
                        C = C or X
                    end
                else
                    if C < 16503074 then
                        X = 1
                        g = 10
                        r = T
                        W = g
                        g = 1
                        c = g
                        g = 0
                        O = c < g
                        g = X - c
                        C = 1659058
                    else
                        X = v(-54288)
                        C = Y[X]
                        h = g
                        X = C(h)
                        C = 1659058
                        h = nil
                    end
                end
            end
            C = #t
            return P(X)
        end, {}
        return (o(16460529, {}))(P(X))
    end)(getfenv and getfenv() or _ENV, unpack or table[v(-54289)], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)