return (function(...)
    local E = {
        "x6==",
        "v0G5xg==",
        "v0Gcu2IwVh==",
        "HUtgxURe",
        "v0Gb4Uk=",
        "QYjzHq7oxvjsUCHOV6==",
        "Sdlcu5+=",
        "xg==",
        "x+=="
    }
    for N, A in ipairs({
        {
            1,
            9
        },
        {
            1,
            4
        },
        {
            5,
            9
        }
    }) do
        while A[1] < A[2] do
            E[A[1]], E[A[2]], A[1], A[2] = E[A[2]], E[A[1]], A[1] + (1), A[2] - (1)
        end
    end
    local function N(N)
        return E[N - (34895)]
    end
    do
        local N = string.char
        local A = string.sub
        local K = type
        local b = table.insert
        local c = math.floor
        local v = E
        local Y = table.concat
        local P = {
            k = 56,
            N = 62,
            F = 47,
            U = 22,
            L = 20,
            b = 44,
            D = 58,
            C = 6,
            s = 36,
            Z = 33,
            ["3"] = 8,
            T = 63,
            I = 17,
            V = 30,
            t = 57,
            i = 1,
            c = 41,
            S = 28,
            r = 35,
            Q = 26,
            J = 42,
            n = 19,
            q = 55,
            e = 43,
            w = 37,
            u = 27,
            m = 18,
            l = 9,
            a = 60,
            p = 11,
            A = 4,
            ["9"] = 46,
            ["/"] = 14,
            h = 0,
            ["8"] = 49,
            z = 12,
            H = 29,
            ["0"] = 53,
            X = 31,
            K = 15,
            ["1"] = 45,
            g = 48,
            ["2"] = 38,
            B = 21,
            y = 34,
            Y = 51,
            ["7"] = 40,
            W = 52,
            j = 5,
            R = 13,
            ["6"] = 32,
            O = 10,
            f = 2,
            ["+"] = 16,
            M = 3,
            G = 61,
            o = 54,
            v = 23,
            E = 50,
            ["5"] = 39,
            P = 59,
            ["4"] = 25,
            x = 24,
            d = 7
        }
        local h = string.len
        for E = 1, #v, 1 do
            local J = v[E]
            if K(J) == "string" then
                local K = h(J)
                local D = {}
                local L = 1
                local r = 0
                local O = 0
                while L <= K do
                    local E = A(J, L, L)
                    local v = P[E]
                    if v then
                        r = r + v * (64) ^ ((3) - O)
                        O = O + (1)
                        if O == 4 then
                            O = 0
                            local E = c(r / (65536))
                            local A = c((r % (65536)) / (256))
                            local K = r % (256)
                            b(D, N(E, A, K))
                            r = 0
                        end
                    elseif E == "=" then
                        b(D, N(c(r / (65536))))
                        if L >= K or A(J, L + (1), L + (1)) ~= "=" then
                            b(D, N(c((r % (65536)) / (256))))
                        end
                        break
                    end
                    L = L + (1)
                end
                v[E] = Y(D)
            end
        end
    end
    return (function(E, K, b, c, v, Y, P, x, L, D, J, h, S, A, r, O)
        x, S, O, A, J, D, h, r, L = function(E)
            J[E] = J[E] - (1)
            if J[E] == 0 then
                J[E], h[E] = nil, nil
            end
        end, function(E, N)
            local K = r(N)
            local b = function(...)
                return A(E, {
                    ...
                }, N, K)
            end
            return b
        end, function(E)
            local N, A = 1, E[1]
            while A do
                J[A], N = J[A] - (1), (1) + N
                if J[A] == 0 then
                    J[A], h[A] = nil, nil
                end
                A = E[N]
            end
        end, function(A, b, c, v)
            local x, L, D, P, J, h, r, O
            while A do
                if A < 10815544 then
                    if A < 9469906 then
                        if A < 7948472 then
                            if A < 620373 then
                                J = 2
                                A = 12505620
                                D = J
                                P = 1
                                J = 2
                                L = J
                                J = 0
                                r = L < J
                                J = P - L
                            else
                                h = b
                                A = 15630346
                                P = 1
                                J = 10
                                D = J
                                J = 1
                                L = J
                                J = 0
                                r = L < J
                                J = P - L
                            end
                        else
                            P = N(34897)
                            A = E[P]
                            O = J
                            x = N(34899)
                            P = A(x, O)
                            A = 15630346
                            O = nil
                        end
                    else
                        if A < 10212232 then
                            O = not r
                            J = J + L
                            P = J <= D
                            P = O and P
                            O = J >= D
                            O = r and O
                            P = O or P
                            O = 13783931
                            A = P and O
                            P = 15832167
                            A = A or P
                        else
                            P = 3
                            J = 1
                            D = J
                            A = 10028406
                            J = -1
                            L = J
                            J = 0
                            r = L < J
                            J = P - L
                        end
                    end
                else
                    if A < 15454752 then
                        if A < 13988601 then
                            if A < 12674458 then
                                J = J + L
                                P = J <= D
                                O = not r
                                P = O and P
                                O = J >= D
                                O = r and O
                                P = O or P
                                O = 14171382
                                A = P and O
                                P = 10769681
                                A = A or P
                            else
                                O = J
                                P = N(34897)
                                x = N(34898)
                                A = E[P]
                                P = A(x, O)
                                O = nil
                                A = 10028406
                            end
                        else
                            P = N(34897)
                            A = E[P]
                            O = J
                            x = N(34900)
                            P = A(x, O)
                            O = nil
                            A = 12505620
                        end
                    else
                        if A < 15663440 then
                            J = J + L
                            O = not r
                            P = J <= D
                            P = O and P
                            O = J >= D
                            O = r and O
                            P = O or P
                            O = 9435818
                            A = P and O
                            P = 106344
                            A = A or P
                        else
                            P = {}
                            A = E[N(34896)]
                        end
                    end
                end
            end
            A = #v
            return K(P)
        end, {}, function()
            L = L + (1)
            J[L] = 1
            return L
        end, {}, function(E)
            for N = 1, #E, 1 do
                J[E[N]] = (1) + J[E[N]]
            end
            if b then
                local A = b(true)
                local K = v(A)
                K[N(34902)], K[N(34901)], K[N(34904)] = E, O, function()
                    return 214072
                end
                return A
            else
                return c({}, {
                    [N(34901)] = O,
                    [N(34902)] = E,
                    [N(34904)] = function()
                        return 214072
                    end
                })
            end
        end, 0
        return (S(6058829, {}))(K(P))
    end)(getfenv and getfenv() or _ENV, unpack or table[N(34903)], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)