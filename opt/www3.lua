--headers


local args = { ... }

--body















































local r_v2_1 = true





local r_v5_1 = debug

local r_v6_1 = args

local r_v7_1 = (r_v5_1) and (debug.sethook)



local r_v9_1 = (r_v7_1) or (function()
        --headers
    
    
        --body
    
        
    end)

local r_v1_3 = nil

local r_v7_2 = r_v9_1

local r_v1_4 = 0









r_v7_2(function(r_v6_2, r_v2_5)
    --headers


    --body

    
    
    
    
    if (not r_v2_5) then
    
        return
    
    end
    
    
    
    
    
    
    
    r_v1_4 = r_v1_4 + 1
    
    
    
    if r_v1_3 then
    
        
    
        
    
        if (r_v1_3 ~= r_v2_5) then
    
            
    
            
    
            
    
            
    
            
    
            r_v7_2(error, "l", 5)
    
        end
    
    else
    
        
    
        r_v1_3 = r_v2_5
    
    end
    
    r_v2_5 = nil
    
    
    
    
end, "l", 5)



;(function()
    --headers


    --body

    
end)()



;(function()
    --headers


    --body

    
end)()



r_v7_2()







if (r_v1_4 < 2) then

    

    r_v2_1 = false

end







if (r_v1_4 < 2) then

    

    r_v2_1 = false

end



local r_v8_5 = pcall







local r_v10_3 = string.char







local r_v12_2 = debug.getinfo







local r_v11_4 = string.dump

local r_v4_6 = {
                                                                    r_v8_5,
                                                                    r_v10_3,
                                                                    r_v12_2,
                                                                    r_v11_4
                                                                }

local r_v12_3 = #r_v4_6









for r_v8_11 = 1, r_v12_3 do

    

    

    

    

    

    

    

    

    

    

    if (debug.getinfo(r_v4_6[r_v8_11]).what ~= "C") then

        

        r_v2_1 = false

    end

    

    

    

    

    

    

    

    if debug.getlocal(r_v4_6[r_v8_11], 1) then

        

        r_v2_1 = false

    end

    

    

    

    

    

    

    

    if debug.getupvalue(r_v4_6[r_v8_11], 1) then

        

        r_v2_1 = false

    end

    

    local r_v16_8 = pcall

    

    

    

    local r_v22_5 = string.dump

    

    

    if r_v16_8(r_v22_5, r_v4_6[r_v8_11]) then

        

        r_v2_1 = false

    end

end



local r_v10_8 = (function()
    --headers


    --body

    local r_v1_29 = function(r_v6_30)
        --headers
    
    
        --body
    
        
        
        
        
        
        
        
        
        return debug.traceback(r_v6_30)
    end
    
    local r_v6_4 = "YyJhLMlfd6zU"
    
    
    
    r_v6_4 = r_v1_29(r_v6_4)
    
    return r_v6_4
end)()

local r_v13_5 = r_v2_1

local r_v12_4 = r_v13_5

if r_v13_5 then

    

    

    

    local r_v19_3 = r_v10_8:find("\n")

    

    

    

    

    

    local r_v15_7 = r_v10_8:sub(1, (r_v19_3 - 1))

    

    

    r_v12_4 = r_v15_7 == "YyJhLMlfd6zU"

end

r_v2_1 = r_v12_4







local r_v11_9 = r_v10_8:gmatch(":(%d*):")

local r_v13_8 = r_v11_9()

local r_v22_3 = nil

local r_v15_8 = 1

local r_v21_2 = nil

local r_v19_4 = r_v11_9

while true do

    

    

    r_v21_2 = r_v19_4(r_v22_3, r_v21_2)

    if not (r_v21_2) then
        break
    end

    

    

    

    r_v2_1 = (r_v2_1) and (r_v21_2 == r_v13_8)

    

    

    

    r_v15_8 = r_v15_8 + 1

end









r_v2_1 = (r_v2_1) and (r_v15_8 >= 2)







local r_v21_6 = string.gmatch





local r_v21_7 = function()
    --headers


    --body

    
    
    
    
    
    
    error("Tamper Detected!")
    
    
end



local r_v24_4 = false









if pcall(function()
    --headers


    --body

    
    
    r_v24_4 = true
    
    
end) then

    

    

end









local r_v26_2 = math.random







local r_v26_3 = table.concat







local r_v27_5 = ((table) and (table.unpack)) or (unpack)











local r_v33_2 = r_v26_2(3, 65)







local r_v34_4 = {
                                                                    pcall(function()
    --headers


    --body

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    return ("Vm0htNoNzgTP7" / (14227012 - ("Gex6YKf" ^ 296778)))
end)
                                                                }

local __beta_unused_return_2, r_v31_4 = unpack(r_v34_4)







local r_v34_6 = tonumber







local r_v37_2 = tostring(r_v31_4)







local r_v35_3 = r_v34_6((r_v21_6(r_v37_2, ":(%d*):"))())



local r_v39_2 = r_v33_2







local r_v33_3 = 0

local r_v30_3 = 0

for r_v35_9 = 1, r_v39_2 do

    

    

    

    

    

    

    

    

    

    local r_v42_2 = math.random(1, 100)

    

    

    

    local r_v41_4 = r_v26_2(0, 255)

    

    

    

    local r_v43_3 = r_v26_2(1, r_v42_2)

    

    

    

    local r_v45_2 = r_v26_2(1, 2)

    

    local r_v43_4 = r_v45_2 == 1

    

    

    

    

    

    

    

    

    

    

    

    

    

    

    local r_v43_7 = r_v31_4:gsub(":(%d*):", (":" .. ((tostring(r_v26_2(0, 10000))) .. ":")))

    local r_v45_4

    local r_v54_2 = function()
        --headers
    
    
        --body
    
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        if ((r_v26_2(1, 2) == 1) or ((r_v35_9) == r_v33_2)) then
        
            
        
            
        
            
        
            local r_v1_34 = tonumber
        
            
        
            
        
            local r_v7_15 = tostring
        
            
        
            
        
            
        
            local r_v10_21 = {
                                                                    pcall(function()
                --headers
            
            
                --body
            
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                return ("DDH2JTqTNg0" / (5489359 - ("pUBRrG1KJaDs31" ^ 3504612)))
            end)
                                                                }
        
            local __beta_unused_return_1, r_v5_12 = unpack(r_v10_21)
        
            
        
            
        
            
        
            
        
            
        
            local r_v6_11 = r_v1_34((r_v21_6((r_v7_15(r_v5_12)), ":(%d*):"))())
        
            
        
            
        
            
        
            r_v2_1 = (r_v2_1) and ((r_v35_3) == r_v6_11)
        
            
        
        end
        
        
        
        if r_v43_4 then
        
            
        
            
        
            
        
            
        
            error(r_v45_4, 0)
        
        end
        
        local r_v6_14 = {}
        
        
        
        
        
        local r_v3_9 = r_v42_2
        
        
        
        
        
        
        
        for r_v2_19 = 1, r_v3_9 do
        
            
        
            
        
            
        
            
        
            r_v6_14[r_v2_19] = r_v26_2(0, 255)
        
        end
        
        
        
        
        
        r_v6_14[r_v43_3] = r_v41_4
        
        
        
        return r_v27_5(r_v6_14)
    end

    r_v45_4 = r_v43_7

    

    

    local r_v46_4 = {
                                                                        pcall(r_v54_2)
                                                                    }

    local r_v43_8 = {
                                                                        unpack(r_v46_4)
                                                                    }

    

    if r_v43_4 then

        

        local r_v54_3 = r_v2_1

        local r_v47_5 = r_v54_3

        if r_v54_3 then

            

            

            local r_v50_2 = r_v43_8[1]

            

            local r_v48_3 = r_v50_2 == false

            local r_v54_5 = r_v48_3

            if r_v48_3 then

                

                local r_v50_6 = r_v43_8[2]

                

                

                r_v54_5 = r_v50_6 == r_v45_4

            end

            r_v47_5 = r_v54_5

        end

        r_v2_1 = r_v47_5

    else

        

        

        r_v2_1 = (r_v2_1) and (r_v43_8[1])

        

        

        

        local r_v48_5 = r_v43_8[r_v43_3 + 1]

        

        

        local r_v54_6 = (r_v33_3 + r_v48_5) % 256

        

        

        

        local r_v49_7 = (r_v30_3 + r_v41_4) % 256

        r_v33_3 = r_v54_6

        r_v30_3 = r_v49_7

    end

    

end



r_v2_1 = (r_v2_1) and (r_v33_3 == r_v30_3)



if r_v2_1 then

    

    

    

    

    

    

    

    

    

    

    local r_v2_3 = nil

    

    local r_v7_5 = nil

    

    

    

    

    

    local r_v7_6 = math.floor

    

    

    

    

    local r_v7_7 = math.random

    

    local r_v15_14 = {}

    

    

    

    

    local r_v4_10 = table.remove

    

    

    

    

    local r_v8_16 = string.char

    

    local r_v10_12 = 0

    local r_v10_13 = 2

    

    

    

    local r_v19_12 = {}

    

    

    

    

    

    

    

    

    for r_v20_14 = 1, 256 do

        

        r_v19_12[r_v20_14] = r_v20_14

    end

    repeat

        

        

        

        local r_v24_12 = r_v4_10(r_v19_12, (r_v7_7(1, #r_v19_12)))

        

        

        

        

        r_v15_14[r_v24_12] = r_v8_16(r_v24_12 - 1)

        

        

        local r_v24_13 = #r_v19_12

        local r_v26_9 = 0

        

    until r_v24_13 == r_v26_9

    local r_v20_18 = {}

    local r_v26_10 = function()
        --headers
    
    
        --body
    
        
        
        
        
        
        
        
        
        if ((#r_v20_18) == 0) then
        
            
        
            
        
            
        
            
        
            
        
            
        
            
        
            r_v10_12 = ((r_v10_12 * 49) + 9689285165057) % 35184372088832
        
            repeat
        
                
        
                
        
                
        
                
        
                
        
                r_v10_13 = (r_v10_13 * 66) % 257
        
                local r_v2_30 = r_v10_13
        
                local r_v7_28 = 1
        
                
        
            until r_v2_30 ~= r_v7_28
        
            
        
            
        
            local r_v6_27 = r_v10_13 % 32
        
            
        
            
        
            
        
            
        
            
        
            
        
            
        
            
        
            
        
            local r_v10_23 = 2 ^ (13 - ((r_v10_13 - r_v6_27) / 32))
        
            
        
            local r_v5_14 = r_v7_6(r_v10_12 / r_v10_23)
        
            
        
            local r_v7_30 = r_v5_14 % 4294967296
        
            
        
            local r_v3_12 = 2 ^ r_v6_27
        
            local r_v2_32 = r_v7_30 / r_v3_12
        
            
        
            
        
            
        
            
        
            
        
            local r_v5_16 = r_v7_6((r_v2_32 % 1) * 4294967296)
        
            
        
            local r_v4_17 = r_v7_6(r_v2_32)
        
            local r_v7_31 = r_v5_16 + r_v4_17
        
            
        
            local r_v3_15 = r_v7_31 % 65536
        
            
        
            
        
            local r_v5_18 = (r_v7_31 - r_v3_15) / 65536
        
            
        
            local r_v4_19 = r_v3_15 % 256
        
            
        
            
        
            local r_v8_30 = (r_v3_15 - r_v4_19) / 256
        
            
        
            local r_v10_27 = r_v5_18 % 256
        
            
        
            
        
            local r_v12_10 = (r_v5_18 - r_v10_27) / 256
        
            
        
            r_v20_18 = {
                                                                r_v4_19,
                                                                r_v8_30,
                                                                r_v10_27,
                                                                r_v12_10
                                                            }
        
            
        
            
        
            
        
            
        
            
        
            
        
            
        
            
        
            
        
        end
        
        
        
        
        
        
        
        
        
        
        
        return table.remove(r_v20_18)
    end

    local r_v27_13 = {}

    local r_v26_11 = {}

    

    local r_v7_8 = function(r_v6_28, r_v2_33, r_v7_32, r_v3_16, r_v5_19, r_v4_20, r_v8_31, r_v10_28, r_v12_11, r_v11_23, r_v13_19, r_v14_10, r_v18_5, r_v17_10, r_v16_10, r_v15_24)
        --headers
    
    
        --body
    
        local r_v21_17 = {}
        
        local r_v28_14 = {}
        
        
        
        
        
        local r_v19_14 = {}
        
        
        
        
        
        
        
        
        
        local r_v24_17 = function(r_v6_33, r_v2_38, r_v7_35, r_v3_18)
            --headers
        
        
            --body
        
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            local r_v5_22 = nil
            
            
            
            while true do
            
                if not (r_v6_33) then
                    break
                end
            
                
            
                
            
                
            
                
            
                
            
                
            
                local r_v5_23 = r_v7_5[r_v2_3("U\217\247\254-", 6982911115264)]
            
                
            
                
            
                
            
                
            
                
            
                
            
                local r_v10_38 = r_v7_5[r_v2_3("3\255[", 16191057920000)]
            
                
            
                local r_v6_34 = r_v6_28[r_v5_23]
            
                
            
                
            
                local r_v13_23 = {}
            
                r_v6_34(r_v10_38)
            
                
            
                
            
                
            
                
            
                
            
                
            
                
            
                
            
                
            
                local r_v14_15 = r_v6_28[r_v7_5[r_v2_3("S\173\015)\223\"\234\229\191\255\248\244g\177", 22940299231232)]]
            
                r_v5_22 = r_v13_23
            
                r_v6_33 = r_v14_15
            
            end
            
            
            
            
            
            local r_v16_15 = {
                                                                r_v2_33(r_v5_22)
                                                            }
            
            
            
            return unpack(r_v16_15)
        end
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        r_v10_28 = (function(r_v6_38)
            --headers
        
        
            --body
        
            local r_v7_41 = #r_v6_38
            
            
            
            
            
            
            
            
            
            for r_v4_32 = 1, r_v7_41 do
            
                
            
                local r_v9_50 = r_v6_38[r_v4_32]
            
                
            
                
            
                local r_v10_39 = r_v13_19[r_v6_38[r_v4_32]]
            
                
            
                
            
                r_v13_19[r_v9_50] = r_v10_39 + 1
            
            end
            
            
            
            if r_v7_32 then
            
                
            
                local r_v2_48 = true
            
                
            
                r_v2_48 = r_v7_32(r_v2_48)
            
                
            
                local r_v7_42 = r_v5_19(r_v2_48)
            
                
            
                
            
                
            
                
            
                
            
                
            
                local r_v1_69 = r_v7_5[r_v2_3("\014\169\202\179x\190\219", 13430002860032)]
            
                
            
                
            
                
            
                
            
                
            
                local r_v9_54 = r_v7_5[r_v2_3("c\254c%", 10206376034304)]
            
                
            
                
            
                
            
                
            
                
            
                local r_v3_24 = r_v7_5[r_v2_3("\137\230\170d6", 18211502227456)]
            
                
            
                
            
                
            
                r_v7_42[r_v1_69] = r_v6_38
            
                r_v7_42[r_v9_54] = r_v12_11
            
                r_v7_42[r_v3_24] = (function()
                    --headers
                
                
                    --body
                
                    
                    
                    return (-3708010)
                end)
            
                return r_v2_48
            
            end
            
            local r_v2_49 = {}
            
            
            
            
            
            
            
            
            
            
            
            
            
            local r_v3_25 = r_v7_5[r_v2_3("!\250>x", 3222513516544)]
            
            
            
            
            
            
            
            
            
            
            
            
            
            local r_v4_38 = r_v7_5[r_v2_3("\023\189E\160\161\029\015", 20028734914560)]
            
            
            
            
            
            
            
            
            
            
            
            local r_v8_45 = r_v7_5[r_v2_3("\175?\000\130\023", 13962456875008)]
            
            
            
            local r_v7_43 = {
                                                                [r_v3_25] = r_v12_11,
                                                                [r_v4_38] = r_v6_38,
                                                                [r_v8_45] = (function()
                --headers
            
            
                --body
            
                
                
                return (-3708010)
            end)
                                                            }
            
            return r_v3_16(r_v2_49, r_v7_43)
        end)
        
        r_v16_10 = r_v21_17
        
        r_v13_19 = r_v19_14
        
        r_v12_11 = (function(r_v6_37)
            --headers
        
        
            --body
        
            
            
            
            
            
            
            
            
            
            
            
            
            local r_v9_41 = r_v6_37[1]
            
            local r_v2_43 = 1
            
            local r_v7_40 = r_v9_41
            
            while true do
            
                if not (r_v7_40) then
                    break
                end
            
                
            
                
            
                local r_v3_19 = r_v13_19[r_v7_40]
            
                
            
                local r_v9_42 = r_v3_19 - 1
            
                
            
                local r_v3_20 = 1 + r_v2_43
            
                r_v13_19[r_v7_40] = r_v9_42
            
                
            
                local r_v9_43 = r_v13_19[r_v7_40]
            
                
            
                local r_v1_61 = r_v9_43 == 0
            
                r_v2_43 = r_v3_20
            
                if r_v1_61 then
            
                    
            
                    
            
                    
            
                    r_v13_19[r_v7_40] = nil
            
                    
            
                    r_v16_10[r_v7_40] = nil
            
                end
            
                
            
                r_v7_40 = r_v6_37[r_v2_43]
            
            end
            
            r_v6_37 = nil
            
            
            
            
            
            
        end)
        
        
        
        r_v11_23 = 0
        
        r_v18_5 = r_v24_17
        
        
        
        
        
        
        
        
        
        
        
        return ((function(r_v6_39, r_v2_50)
            --headers
        
        
            --body
        
            
            
            
            
            local r_v7_45 = r_v10_28(r_v2_50)
            
            
            
            
            
            
            
            
            
            return (function(...)
                --headers
            
            
                --body
            
                local r_v7_46 = {
                                                        ...
                                                    }
                
                
                
                
                
                
                
                
                
                return r_v18_5(r_v6_39, r_v7_46, r_v2_50, r_v7_45)
            end)
        end)(12574187, r_v28_14))(r_v2_33(r_v8_31))
    end

    

    

    

    

    

    

    

    local r_v28_13 = setmetatable(r_v27_13, {
                                                                        ["__index"] = r_v26_11,
                                                                        ["__metatable"] = nil
                                                                    })

    local r_v26_13 = function(r_v6_29, r_v2_34)
        --headers
    
    
        --body
    
        
        
        
        
        
        
        
        
        
        
        
        
        local r_v7_33 = r_v26_11
        
        
        
        if not (r_v7_33[r_v2_34]) then
        
            
        
            
        
            
        
            r_v20_18 = {}
        
            
        
            local r_v3_17 = r_v15_14
        
            
        
            
        
            r_v10_12 = r_v2_34 % 35184372088832
        
            
        
            
        
            
        
            
        
            r_v10_13 = (r_v2_34 % 255) + 2
        
            
        
            
        
            
        
            
        
            local r_v8_35 = string.len(r_v6_29)
        
            
        
            
        
            
        
            r_v7_33[r_v2_34] = ""
        
            
        
            local r_v12_12 = r_v8_35
        
            local r_v4_24 = 118
        
            for r_v10_36 = 1, r_v12_12 do
        
                
        
                
        
                
        
                
        
                local r_v22_9 = string.byte(r_v6_29, r_v10_36)
        
                
        
                local r_v21_20 = r_v26_10()
        
                
        
                
        
                
        
                
        
                r_v4_24 = ((r_v22_9 + r_v21_20) + r_v4_24) % 256
        
                local r_v16_13 = r_v7_33[r_v2_34]
        
                
        
                
        
                local r_v15_28 = r_v3_17[r_v4_24 + 1]
        
                
        
                r_v7_33[r_v2_34] = r_v16_13 .. r_v15_28
        
            end
        
            
        
            
        
            
        
        end
        
        return r_v2_34
    end

    r_v7_5 = r_v28_13

    r_v2_3 = r_v26_13

    

    

    

    

    local r_v10_16 = (getfenv) and (getfenv())

    local r_v4_11 = (r_v10_16) or (_ENV)

    

    

    

    local r_v8_18 = (unpack) or ((table).unpack)

    

    

    local r_v10_19 = newproxy

    

    local r_v11_18 = setmetatable

    

    local r_v13_15 = getmetatable

    

    local r_v15_21 = select

    local r_v21_15 = {
                                                                        unpack(r_v6_1)
                                                                    }

    return r_v7_8(r_v4_11, r_v8_18, r_v10_19, r_v11_18, r_v13_15, r_v15_21, r_v21_15)

end





return (function()
    --headers


    --body

    while true do
    
        
    
        if not (true) then
            break
        end
    
        
    
        local r_v1_43 = l2
    
        
    
        local r_v9_24 = l1
    
        
    
        l1 = r_v1_43
    
        
    
        l2 = r_v9_24
    
        
    
        r_v21_7()
    
    end
    
    
end)()
