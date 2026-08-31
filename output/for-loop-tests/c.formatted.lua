return (function(...)
    local V = {
        "oleape9lnc9fBlkIBNS=",
        "2GZ8Acb=",
        "dex8A+U36R==",
        "dexSVrq=",
        "hrDuornf",
        "dexcou=="
    }
    for O, w in ipairs({
        {
            1,
            6
        },
        {
            1,
            5
        },
        {
            6,
            6
        }
    }) do
        while w[1] < w[2] do
            V[w[1]], V[w[2]], w[1], w[2] = V[w[2]], V[w[1]], w[1] + (1), w[2] - (1)
        end
    end
    local function O(O)
        return V[O + (35457)]
    end
    do
        local O = string.char
        local w = string.len
        local z = type
        local E = table.insert
        local n = V
        local k = {
            K = 49,
            e = 53,
            v = 6,
            ["4"] = 62,
            n = 13,
            ["0"] = 26,
            c = 39,
            O = 5,
            p = 12,
            x = 61,
            V = 25,
            s = 47,
            q = 56,
            B = 18,
            m = 40,
            u = 48,
            t = 4,
            ["5"] = 14,
            ["/"] = 10,
            g = 35,
            L = 51,
            r = 22,
            Q = 58,
            k = 45,
            a = 11,
            j = 31,
            G = 7,
            l = 54,
            z = 32,
            X = 46,
            A = 27,
            w = 15,
            P = 55,
            h = 29,
            E = 59,
            D = 57,
            d = 23,
            J = 3,
            Y = 36,
            H = 20,
            T = 8,
            ["2"] = 28,
            ["8"] = 41,
            F = 19,
            N = 52,
            ["1"] = 42,
            W = 60,
            i = 21,
            ["7"] = 63,
            Z = 9,
            o = 24,
            U = 17,
            R = 0,
            M = 34,
            ["6"] = 30,
            b = 16,
            C = 50,
            y = 1,
            I = 2,
            ["3"] = 37,
            f = 43,
            S = 44,
            ["9"] = 33,
            ["+"] = 38
        }
        local m = string.sub
        local J = math.floor
        local K = table.concat
        for V = 1, #n, 1 do
            local Y = n[V]
            if z(Y) == "string" then
                local z = w(Y)
                local Q = {}
                local h = 1
                local t = 0
                local p = 0
                while h <= z do
                    local V = m(Y, h, h)
                    local w = k[V]
                    if w then
                        t = t + w * (64) ^ ((3) - p)
                        p = p + (1)
                        if p == 4 then
                            p = 0
                            local V = J(t / (65536))
                            local w = J((t % (65536)) / (256))
                            local z = t % (256)
                            E(Q, O(V, w, z))
                            t = 0
                        end
                    elseif V == "=" then
                        E(Q, O(J(t / (65536))))
                        if h >= z or m(Y, h + (1), h + (1)) ~= "=" then
                            E(Q, O(J((t % (65536)) / (256))))
                        end
                        break
                    end
                    h = h + (1)
                end
                n[V] = K(Q)
            end
        end
    end
    return (function(V, z, E, n, k, m, J, p, i, t, Q, Y, w, A, K, h)
        K, Q, p, A, w, h, i, t, Y = {}, function()
            h = h + (1)
            Y[h] = 1
            return h
        end, function(V)
            local O, w = 1, V[1]
            while w do
                Y[w], O = Y[w] - (1), O + (1)
                if 0 == Y[w] then
                    Y[w], K[w] = nil, nil
                end
                w = V[O]
            end
        end, function(V)
            Y[V] = Y[V] - (1)
            if 0 == Y[V] then
                Y[V], K[V] = nil, nil
            end
        end, function(w, E, n, k)
            local Q, h, K, p, t, J, Y
            while w do
                if w < 4757547 then
                    if w < 2596626 then
                        w = V[O(-35451)]
                        J = {}
                    else
                        p = not t
                        Y = Y + h
                        J = Y <= Q
                        J = p and J
                        p = Y >= Q
                        p = t and p
                        J = p or J
                        p = 5092090
                        w = J and p
                        J = 435923
                        w = w or J
                    end
                else
                    if w < 5864185 then
                        J = O(-35456)
                        w = V[J]
                        p = Y
                        J = w(p)
                        w = 4087230
                        p = nil
                    else
                        J = 3
                        Y = 1
                        Q = Y
                        K = E
                        Y = -1
                        h = Y
                        Y = 0
                        t = h < Y
                        Y = J - h
                        w = 4087230
                    end
                end
            end
            w = #k
            return z(J)
        end, 0, function(V, O)
            local z = t(O)
            local E = function(...)
                return w(V, {
                    ...
                }, O, z)
            end
            return E
        end, function(V)
            for O = 1, #V, 1 do
                Y[V[O]] = (1) + Y[V[O]]
            end
            if E then
                local w = E(true)
                local z = k(w)
                z[O(-35455)], z[O(-35452)], z[O(-35454)] = V, p, function()
                    return -869558
                end
                return w
            else
                return n({}, {
                    [O(-35452)] = p,
                    [O(-35455)] = V,
                    [O(-35454)] = function()
                        return -869558
                    end
                })
            end
        end, {}
        return (i(9491315, {}))(z(J))
    end)(getfenv and getfenv() or _ENV, unpack or table[O(-35453)], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)