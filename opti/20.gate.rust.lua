--headers




--body







print("testing language/library basics")





getfenv()







concat = function(...)
    --headers

    

    --body

    
    
    
    
    local r_v12_2 = (select(1, ...))
    
    
    
    
    
    
    
    
    
    
    
    
    
    if (select("#", select(2, ...)) == 0) then
    
        
    
        
    
        return tostring(r_v12_2)
    
    end
    
    
    
    
    
    local r_v1_6 = tostring(r_v12_2)
    
    
    
    
    
    local r_v6_40 = concat(select(2, ...))
    
    
    
    local r_v2_32 = "," .. r_v6_40
    
    
    
    return (r_v1_6 .. r_v2_32)
end

local r_v2_6 = function(...)
    --headers

    

    --body

    local r_v4_5 = (select(2, ...))
    
    select(1, ...)
    
    return r_v4_5
end















assert((r_v2_6(1)) == nil)

















assert((r_v2_6(1, 2)) == 2)



















assert((r_v2_6(1, 2, 3)) == 2)















assert(((function(...)
    --headers

    

    --body

    local r_v3_7 = 1
    
    
    
    r_v2_6 = function(...)
        --headers
    
        
    
        --body
    
        
        
        return r_v3_7
    end
    
    
    
    return r_v2_6()
end)()) == 1)



local r_v2_11 = assert

local r_v8_5 = (function(...)
    --headers

    

    --body

    local r_v3_9 = 1
    
    
    
    r_v2_6 = function(...)
        --headers
    
        
    
        --body
    
        
        
        return (function(...)
            --headers
        
            
        
            --body
        
            
            
            return r_v3_9
        end)
    end
    
    
    
    
    
    return (r_v2_6())()
end)()



local r_v9_5 = r_v8_5 == 1

local r_v6_11 = function(...)
    --headers

    

    --body

    
    
    r_v2_6 = function(...)
        --headers
    
        
    
        --body
    
        local r_v12_21 = (select(1, ...))
        
        
        
        return (function(...)
            --headers
        
            
        
            --body
        
            
            
            return r_v12_21
        end)
    end
    
    
    
    
    
    
    
    return (r_v2_6(1))()
end

r_v2_11(r_v9_5)













assert((r_v6_11()) == 1)













assert(((function(...)
    --headers

    

    --body

    
    
    r_v2_6 = function(...)
        --headers
    
        
    
        --body
    
        
        
        local r_v12_22 = nil
        
        local r_v3_39 = 1
        
        
        
        r_v12_22 = function(...)
            --headers
        
            
        
            --body
        
            
            
            return r_v3_39
        end
        
        
        
        
        
        return r_v12_22
    end
    
    
    
    
    
    return (r_v2_6())()
end)()) == 1)











assert(((function(...)
    --headers

    

    --body

    
    
    r_v2_6 = function(...)
        --headers
    
        
    
        --body
    
        local r_v3_41 = 1
        
        
        
        
        
        
        
        r_v3_41 = 2
        
        return (function(...)
            --headers
        
            
        
            --body
        
            
            
            return r_v3_41
        end)
    end
    
    
    
    
    
    return (r_v2_6())()
end)()) == 2)













assert(((function(...)
    --headers

    

    --body

    
    
    r_v2_6 = function(...)
        --headers
    
        
    
        --body
    
        local r_v3_44 = 1
        
        
        
        ;(function(...)
            --headers
        
            
        
            --body
        
            
            
            r_v3_44 = 2
            
            
        end)()
        
        
        
        return r_v3_44
    end
    
    
    
    return r_v2_6()
end)()) == 2)



local r_v2_16 = assert



local r_v8_10 = (function(...)
    --headers

    

    --body

    
    
    
    
    local r_v12_11 = {
                                                    ["f"] = 5
                                                }
    
    
    
    
    
    
    
    r_v12_11["get"] = function(...)
        --headers
    
        
    
        --body
    
        
        
        
        
        local r_v12_25 = (select(1, ...))
        
        return (function(...)
            --headers
        
            
        
            --body
        
            
            
            
            
            local r_v3_56 = r_v12_25["f"]
            
            return r_v3_56
        end)()
    end
    
    
    
    
    
    return r_v12_11:get()
end)()



local r_v9_10 = r_v8_10 == 5

local r_v6_21 = function(...)
    --headers

    

    --body

    
    
    r_v2_6 = function(...)
        --headers
    
        
    
        --body
    
        
        
        
        
        local r_v12_27 = {
                                                    ["f"] = 5
                                                }
        
        
        
        
        
        
        
        r_v12_27["get"] = function(...)
            --headers
        
            
        
            --body
        
            local r_v12_29 = (select(1, ...))
            
            
            
            return (function(...)
                --headers
            
                
            
                --body
            
                
                
                
                
                local r_v3_58 = r_v12_29["f"]
                
                return r_v3_58
            end)
        end
        
        
        
        
        
        return r_v12_27:get()
    end
    
    
    
    
    
    return (r_v2_6())()
end

r_v2_16(r_v9_10)











assert((r_v6_21()) == 5)













assert(((function(...)
    --headers

    

    --body

    
    
    
    
    local r_v12_13 = 1
    
    if r_v12_13 then
    
        
    
        r_v12_13 = 2
    
    end
    
    return r_v12_13
end)()) == 2)















assert(((function(...)
    --headers

    

    --body

    
    
    
    
    local r_v12_14 = nil
    
    if r_v12_14 then
    
        
    
        r_v12_14 = 2
    
    end
    
    return r_v12_14
end)()) == nil)











assert(((function(...)
    --headers

    

    --body

    
    
    
    
    local r_v12_15 = 0
    
    if r_v12_15 then
    
        
    
        r_v12_15 = 1
    
    else
    
        
    
        r_v12_15 = 2
    
    end
    
    return r_v12_15
end)()) == 1)















assert(((function(...)
    --headers

    

    --body

    
    
    
    
    local r_v12_16 = nil
    
    if r_v12_16 then
    
        
    
        r_v12_16 = 1
    
    else
    
        
    
        r_v12_16 = 2
    
    end
    
    return r_v12_16
end)()) == 2)











assert(((function(...)
    --headers

    

    --body

    
    
    local r_v12_17 = 1
    
    
    
    
    
    r_v12_17 = r_v12_17 + 2
    
    return r_v12_17
end)()) == 3)





local r_v2_23 = assert

local r_v8_17 = (function(...)
    --headers

    

    --body

    
    
    local r_v12_18 = 1
    
    
    
    
    
    r_v12_18 = r_v12_18 - 2
    
    return r_v12_18
end)()

local r_v6_34 = -1



r_v2_23(r_v8_17 == r_v6_34)













assert(((function(...)
    --headers

    

    --body

    
    
    local r_v12_19 = 1
    
    
    
    
    
    r_v12_19 = r_v12_19 * 2
    
    return r_v12_19
end)()) == 2)













assert(((function(...)
    --headers

    

    --body

    
    
    local r_v12_20 = 1
    
    
    
    
    
    r_v12_20 = r_v12_20 / 2
    
    return r_v12_20
end)()) == 0.5)







print("PASS")






