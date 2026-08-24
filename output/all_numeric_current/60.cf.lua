--headers

local _env = getfenv()
local args = { ... }

--body

local r_v1_1 = "print"

local r_v2_1 = _env[r_v1_1]

local r_v3_1 = "sample60-start"

local r_v1_2 = r_v2_1(r_v3_1)

local r_v2_2 = false

local r_v4_1 = args

while true do

    local r_v2_3 = false

    if not (r_v2_3) then
        break
    end

end

local r_v3_2 = 0

local r_v5_1 = r_v3_2

local r_v3_3 = 1

local r_v6_1 = r_v3_3

local r_v1_3 = 1

for r_v8_5 = r_v1_3, r_v5_1, r_v6_1 do

end

local r_v6_2 = {}

local r_v1_8 = "pairs"

local r_v2_5 = _env[r_v1_8]

local r_v7_2 = {
                                                            r_v2_5(r_v6_2)
                                                        }

local r_v3_6 = r_v7_2[2]

local r_v5_2 = r_v7_2[3]

local r_v1_9 = r_v7_2[1]

local r_v6_3 = r_v1_9

for r_v7_3, r30 in r_v6_3, r_v3_6, r_v5_2 do

end

repeat

    local r_v2_7 = true

until r_v2_7

local r_v2_8 = 0

local r_v5_3 = 10

local r_v8_8 = 40

local r_v7_5 = 30

local r_v6_4 = 20

local r_v2_9 = {
                                                            r_v5_3,
                                                            r_v6_4,
                                                            r_v7_5,
                                                            r_v8_8
                                                        }

r_v5_3 = r_v2_9

local r_v9_1 = -1

local r_v10_1 = 2

local r_v11_1 = 3

local r_v7_6 = 1

local r_v12_1 = "c"

local r_v6_5 = "a"

local r_v8_9 = "b"

local r_v2_10 = {
                                                            [r_v6_5] = r_v7_6,
                                                            [r_v8_9] = r_v10_1,
                                                            [r_v12_1] = r_v11_1
                                                        }

r_v6_5 = r_v2_10

local r_v7_7 = "value"

local r_v8_10 = 3

local r_v2_11 = {
                                                            [r_v7_7] = r_v8_10
                                                        }

r_v7_7 = r_v2_11

local r_v2_12 = "extra"

local r_v8_11 = "field"

r_v7_7[r_v2_12] = r_v8_11

local r_v2_13 = "indexed"

local r_v8_12 = 7

r_v7_7[r_v2_13] = r_v8_12

local r_v2_14 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v4_2 = args[1]
    
    local r_v1_10 = 0
    
    local r_v2_30 = r_v4_2 < r_v1_10
    
    if r_v2_30 then
    
        local r_v2_31 = "neg"
    
        return r_v2_31
    
    end
    
    local r_v1_11 = 0
    
    local r_v2_32 = r_v4_2 == r_v1_11
    
    if r_v2_32 then
    
        local r_v2_33 = "zero"
    
        return r_v2_33
    
    end
    
    local r_v2_34 = "pos"
    
    return r_v2_34
end

local r_v8_13 = r_v2_14

local r_v2_15 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v3_9
    
    local r_v2_35 = function(...)
        --headers
    
        local args = { ... }
    
        --body
    
        local r_v4_9 = args[1]
        
        local r_v1_17 = r_v3_9
        
        local r_v2_41 = r_v1_17 + r_v4_9
        
        r_v3_9 = r_v2_41
        
        local r_v1_18 = r_v3_9
        
        return r_v1_18
    end
    
    local r_v4_3 = args[1]
    
    r_v3_9 = r_v4_3
    
    return r_v2_35
end

local r_v10_2 = r_v2_15

local r_v12_2 = 5

local r_v2_16 = r_v10_2(r_v12_2)

r_v12_2 = r_v2_16

local r_v11_2 = "print"

local r_v2_17 = _env[r_v11_2]

local r_v13_1 = r_v8_13(r_v9_1)

local r_v14_1 = 0

local r_v9_2 = r_v8_13(r_v14_1)

local r_v15_1 = 1

local r_v14_2 = {
                                                            r_v8_13(r_v15_1)
                                                        }

local r_v16_1 = "class"

local r_v11_3 = r_v2_17(r_v16_1, r_v13_1, r_v9_2, unpack(r_v14_2))

local r_v11_4 = "print"

local r_v2_18 = _env[r_v11_4]

local r_v9_3 = 2

local r_v13_2 = r_v12_2(r_v9_3)

local r_v14_3 = 3

local r_v9_4 = {
                                                            r_v12_2(r_v14_3)
                                                        }

local r_v16_2 = "closure"

local r_v11_5 = r_v2_18(r_v16_2, r_v13_2, unpack(r_v9_4))

local r_v2_19 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v3_10 = args[2]
    
    local r_v4_4 = args[1]
    
    local r_v6_6 = "value"
    
    local r_v5_4 = r_v4_4[r_v6_6]
    
    local r_v1_12 = r_v5_4 + r_v3_10
    
    local r_v2_36 = "value"
    
    r_v4_4[r_v2_36] = r_v1_12
    
    local r_v1_13 = "value"
    
    local r_v2_37 = r_v4_4[r_v1_13]
    
    return r_v2_37
end

local r_v11_6 = "add"

r_v7_7[r_v11_6] = r_v2_19

local r_v2_20 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v4_5 = args[1]
    
    local r_v3_11 = args[2]
    
    local r_v5_5 = "value"
    
    local r_v1_14 = r_v4_5[r_v5_5]
    
    local r_v2_38 = r_v1_14 * r_v3_11
    
    return r_v2_38
end

local r_v13_3 = "add"

local r_v13_4 = r_v7_7[r_v13_3]

local r_v11_7 = "mul"

r_v7_7[r_v11_7] = r_v2_20

local r_v11_8 = "print"

local r_v2_21 = _env[r_v11_8]

local r_v9_5 = 2

local r_v13_5 = r_v13_4(r_v7_7, r_v9_5)

local r_v9_6 = "mul"

local r_v9_7 = r_v7_7[r_v9_6]

local r_v14_4 = 3

local r_v9_8 = r_v9_7(r_v7_7, r_v14_4)

local r_v15_2 = "extra"

local r_v14_5 = r_v7_7[r_v15_2]

local r_v17_1 = "indexed"

local r_v15_3 = r_v7_7[r_v17_1]

local r_v16_3 = "namecall"

local r_v11_9 = r_v2_21(r_v16_3, r_v13_5, r_v9_8, r_v14_5, r_v15_3)

local r_v16_4 = 6

local r_v13_6 = r_v16_4

local r_v16_5 = 1

local r_v9_9 = r_v16_5

local r_v11_10 = 1

for r_v11_15 = r_v11_10, r_v13_6, r_v9_9 do

    local r_v15_8 = 2

    local r_v2_23 = r_v11_15 == r_v15_8

    if r_v2_23 then

        continue

    end

    local r_v15_9 = 5

    local r_v2_26 = r_v11_15 == r_v15_9

    if r_v2_26 then

        break

    end

    local r_v15_10 = r_v2_8

    local r_v2_27 = r_v15_10 + r_v11_15

    r_v2_8 = r_v2_27

    local r_v18_2 = 2

    local r_v17_3 = r_v11_15 % r_v18_2

    local r_v18_3 = 0

    local r_v15_11 = r_v17_3 == r_v18_3

    if r_v15_11 then

        local r_v17_5 = "print"

        local r_v15_12 = _env[r_v17_5]

        local r_v19_2 = r_v2_8

        local r_v18_6 = "num-even"

        local r_v17_6 = r_v15_12(r_v18_6, r_v11_15, r_v19_2)

    else

        local r_v17_7 = "print"

        local r_v15_13 = _env[r_v17_7]

        local r_v19_3 = r_v2_8

        local r_v18_7 = "num-odd"

        local r_v17_8 = r_v15_13(r_v18_7, r_v11_15, r_v19_3)

    end

end

local r_v2_24 = 0

local r_v11_16 = r_v2_24

local r_v16_8 = "pairs"

local r_v2_25 = _env[r_v16_8]

local r_v14_7 = {
                                                            r_v2_25(r_v6_5)
                                                        }

local r_v9_10 = r_v14_7[3]

local r_v16_9 = r_v14_7[1]

local r_v13_7 = r_v14_7[2]

for r_v14_8, r12 in r_v16_9, r_v13_7, r_v9_10 do

    local r_v2_28 = r_v11_16 + r12

    r_v11_16 = r_v2_28

    local r_v18_1 = "b"

    local r_v17_2 = r_v14_8 == r_v18_1

    if r_v17_2 then

        local r_v18_4 = 10

        local r_v17_4 = r_v11_16 + r_v18_4

        r_v11_16 = r_v17_4

    else

        local r_v19_1 = 0

        local r_v18_5 = r_v11_16 + r_v19_1

        r_v11_16 = r_v18_5

    end

end

local r_v13_8 = "print"

local r_v16_10 = _env[r_v13_8]

local r_v9_11 = "pairs-sum"

local r_v13_9 = r_v16_10(r_v9_11, r_v11_16)

local r_v13_10 = "next"

local r_v16_11 = _env[r_v13_10]

local r_v9_12 = r_v5_3

local r_v13_11 = nil

for r_v14_9, r12 in r_v16_11, r_v9_12, r_v13_11 do

    local r_v20_1 = 2

    local r_v19_4 = r_v14_9 == r_v20_1

    if r_v19_4 then

        continue

    end

    local r_v20_2 = "print"

    local r_v19_5 = _env[r_v20_2]

    local r_v21_1 = "next"

    local r_v20_3 = r_v19_5(r_v21_1, r_v14_9, r12)

    local r_v20_4 = 3

    local r_v19_6 = r_v14_9 == r_v20_4

    if r_v19_6 then

        break

    end

end

local r_v16_12 = 0

while true do

    local r_v9_13 = 6

    local r_v13_12 = r_v16_12 < r_v9_13

    if not (r_v13_12) then
        break
    end

    local r_v9_14 = 1

    local r_v13_13 = r_v16_12 + r_v9_14

    r_v16_12 = r_v13_13

    local r_v14_10 = 10

    local r_v9_15 = r_v16_12 * r_v14_10

    local r_v15_18 = 2

    local r_v14_11 = r_v16_12 == r_v15_18

    if r_v14_11 then

        r_v9_15 = nil

    else

        local r_v15_20 = 5

        local r_v14_13 = r_v16_12 == r_v15_20

        if r_v14_13 then

            local r_v15_23 = "print"

            local r_v14_15 = _env[r_v15_23]

            local r_v19_9 = "while-break"

            local r_v15_24 = r_v14_15(r_v19_9, r_v9_15)

            r_v9_15 = nil

            break

        else

            local r_v15_25 = "print"

            local r_v14_16 = _env[r_v15_25]

            local r_v19_10 = "while"

            local r_v15_26 = r_v14_16(r_v19_10, r_v16_12, r_v9_15)

            r_v9_15 = nil

        end

    end

end

local r_v9_16 = 0

repeat

    local r_v15_21 = 1

    local r_v14_14 = r_v9_16 + r_v15_21

    r_v9_16 = r_v14_14

    local r_v19_7 = "print"

    local r_v15_22 = _env[r_v19_7]

    local r_v20_5 = "repeat"

    local r_v19_8 = r_v15_22(r_v20_5, r_v9_16)

    local r_v19_11 = 3

    local r_v15_27 = r_v9_16 >= r_v19_11

until r_v15_27

local r_v19_12 = 2

local r_v20_6 = r_v19_12

local r_v19_13 = 1

local r_v21_2 = r_v19_13

local r_v15_28 = 1

for r_v15_33 = r_v15_28, r_v20_6, r_v21_2 do

    local r_v23_5 = 0

    while true do

        local r_v24_2 = 2

        local r_v26_1 = r_v23_5 < r_v24_2

        if not (r_v26_1) then
            break
        end

        local r_v24_3 = 1

        local r_v26_2 = r_v23_5 + r_v24_3

        r_v23_5 = r_v26_2

        local r_v25_2 = "ipairs"

        local r_v24_4 = _env[r_v25_2]

        local r_v27_1 = {
                                                                    r_v15_33,
                                                                    r_v23_5
                                                                }

        local r_v28_1 = {
                                                                    r_v24_4(r_v27_1)
                                                                }

        local r_v29_1 = r_v28_1[2]

        local r_v30_1 = r_v28_1[3]

        local r_v25_3 = r_v28_1[1]

        for r_v24_10, r17 in r_v25_3, r_v29_1, r_v30_1 do

            local r_v31_1 = "print"

            local r_v28_3 = _env[r_v31_1]

            local r_v32_1 = "nested"

            local r_v31_2 = r_v28_3(r_v32_1, r_v15_33, r_v23_5, r_v24_10, r17)

        end

    end

    r_v23_5 = nil

end

local r_v19_16 = "ipairs"

local r_v15_34 = _env[r_v19_16]

local r_v24_1 = 4

local r_v23_6 = 2

local r_v25_1 = 6

local r_v22_2 = {
                                                            r_v23_6,
                                                            r_v24_1,
                                                            r_v25_1
                                                        }

local r_v23_7 = {
                                                            r_v15_34(r_v22_2)
                                                        }

local r_v19_17 = r_v23_7[1]

local r_v21_3 = r_v23_7[3]

local r_v20_7 = r_v23_7[2]

for r_v15_35, r_v23_9 in r_v19_17, r_v20_7, r_v21_3 do

    local r_v23_10 = function(...)
        --headers
    
        local args = { ... }
    
        --body
    
        local r_v4_6 = r_v15_35
        
        local r_v3_12 = r_v23_9
        
        local r_v1_15 = r_v4_6 + r_v3_12
        
        local r_v4_7 = r_v2_8
        
        local r_v2_39 = r_v1_15 + r_v4_7
        
        return r_v2_39
    end

    local r_v25_4 = r_v15_35

    local r_v29_2 = 2

    local r_v24_5 = r_v25_4 == r_v29_2

    if r_v24_5 then

        local r_v25_7 = "print"

        local r_v24_8 = _env[r_v25_7]

        local r_v30_3 = {
                                                                    r_v23_10()
                                                                }

        local r_v29_5 = "capture-a"

        local r_v25_8 = r_v24_8(r_v29_5, unpack(r_v30_3))

    else

        local r_v25_9 = "print"

        local r_v24_9 = _env[r_v25_9]

        local r_v30_4 = {
                                                                    r_v23_10()
                                                                }

        local r_v29_6 = "capture-b"

        local r_v25_10 = r_v24_9(r_v29_6, unpack(r_v30_4))

    end

    r_v23_10 = nil

end

local r_v15_37 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v3_13 = args[2]
    
    local r_v5_6 = args[3]
    
    local r_v4_8 = args[1]
    
    local r_v6_7 = r_v5_6
    
    if r_v5_6 then
    
        r_v6_7 = r_v4_8
    
    end
    
    local r_v1_16 = r_v6_7
    
    if not (r_v6_7) then
    
        r_v1_16 = r_v3_13
    
    end
    
    return r_v1_16
end

local r_v20_8 = "print"

local r_v19_18 = _env[r_v20_8]

local r_v24_6 = "no"

local r_v25_5 = true

local r_v23_11 = "yes"

local r_v22_4 = r_v15_37(r_v23_11, r_v24_6, r_v25_5)

local r_v27_2 = r_v2_8

local r_v28_2 = 0

local r_v30_2 = r_v27_2 > r_v28_2

local r_v27_3 = "positive"

local r_v25_6 = r_v30_2 and r_v27_3

local r_v29_4 = "zero"

local r_v23_12 = r_v25_6 or r_v29_4

local r_v21_4 = "logic"

local r_v20_9 = r_v19_18(r_v21_4, r_v22_4, r_v23_12)

local r_v20_10 = "print"

local r_v19_19 = _env[r_v20_10]

local r_v22_5 = r_v2_8

local r_v21_5 = "sample60-end"

local r_v20_11 = r_v19_19(r_v21_5, r_v22_5, r_v16_12, r_v9_16)

r_v10_2 = nil

r_v5_3 = nil

r_v8_13 = nil

r_v11_16 = nil

r_v12_2 = nil

r_v15_37 = nil

r_v7_7 = nil

r_v6_5 = nil

r_v16_12 = nil

r_v9_16 = nil

return
