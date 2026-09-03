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
    
    
    
    
    
    local r_v4_6 = tostring(r_v12_2)
    
    
    
    
    
    local r_v6_24 = concat(select(2, ...))
    
    
    
    local r_v1_27 = "," .. r_v6_24
    
    
    
    return (r_v4_6 .. r_v1_27)
end

local r_v1_6 = function(...)
    --headers

    

    --body

    local r_v3_5 = (select(2, ...))
    
    select(1, ...)
    
    return r_v3_5
end















assert((r_v1_6(1)) == nil)

















assert((r_v1_6(1, 2)) == 2)



















assert((r_v1_6(1, 2, 3)) == 2)













assert(((function(...)
    --headers

    

    --body

    local r_v2_7 = 1
    
    
    
    r_v1_6 = function(...)
        --headers
    
        
    
        --body
    
        
        
        return r_v2_7
    end
    
    
    
    
    
    return r_v1_6()
end)()) == 1)













assert(((function(...)
    --headers

    

    --body

    local r_v2_9 = 1
    
    
    
    r_v1_6 = function(...)
        --headers
    
        
    
        --body
    
        
        
        return (function(...)
            --headers
        
            
        
            --body
        
            
            
            return r_v2_9
        end)
    end
    
    
    
    
    
    
    
    return (r_v1_6())()
end)()) == 1)













assert(((function(...)
    --headers

    

    --body

    
    
    r_v1_6 = function(...)
        --headers
    
        
    
        --body
    
        
        
        
        
        local r_v12_13 = select(1, ...)
        
        return (function(...)
            --headers
        
            
        
            --body
        
            
            
            return r_v12_13
        end)
    end
    
    
    
    
    
    
    
    
    
    return (r_v1_6(1))()
end)()) == 1)













assert(((function(...)
    --headers

    

    --body

    
    
    r_v1_6 = function(...)
        --headers
    
        
    
        --body
    
        
        
        local r_v12_14 = nil
        
        local r_v2_23 = 1
        
        
        
        r_v12_14 = function(...)
            --headers
        
            
        
            --body
        
            
            
            return r_v2_23
        end
        
        
        
        
        
        return r_v12_14
    end
    
    
    
    
    
    
    
    return (r_v1_6())()
end)()) == 1)







print("o")















assert(((function(...)
    --headers

    

    --body

    
    
    r_v1_6 = function(...)
        --headers
    
        
    
        --body
    
        local r_v2_25 = 1
        
        
        
        
        
        
        
        r_v2_25 = 2
        
        return (function(...)
            --headers
        
            
        
            --body
        
            
            
            return r_v2_25
        end)
    end
    
    
    
    
    
    
    
    return (r_v1_6())()
end)()) == 2)







print("l")











assert(((function(...)
    --headers

    

    --body

    
    
    r_v1_6 = function(...)
        --headers
    
        
    
        --body
    
        local r_v2_28 = 1
        
        
        
        (function(...)
            --headers
        
            
        
            --body
        
            
            
            r_v2_28 = 2
            
            
        end)()
        
        
        
        return r_v2_28
    end
    
    
    
    
    
    return r_v1_6()
end)()) == 2)







print("d")

local r_v6_19 = function(...)
    --headers

    

    --body

    
    
    
    
    local r_v12_11 = {
                                                ["f"] = 5
                                            }
    
    
    
    
    
    
    
    r_v12_11["get"] = function(...)
        --headers
    
        
    
        --body
    
        local r_v12_17 = (select(1, ...))
        
        
        
        
        
        return (function(...)
            --headers
        
            
        
            --body
        
            
            
            
            
            local r_v2_40 = r_v12_17["f"]
            
            return r_v2_40
        end)()
    end
    
    
    
    
    
    
    
    return r_v12_11:get()
end



local r_v1_19 = assert

local r_v8_10 = r_v6_19()



local r_v9_13 = r_v8_10 == 5

local r_v6_21 = function(...)
    --headers

    

    --body

    
    
    r_v1_6 = function(...)
        --headers
    
        
    
        --body
    
        
        
        
        
        local r_v12_19 = {
                                                    ["f"] = 5
                                                }
        
        
        
        
        
        
        
        r_v12_19["get"] = function(...)
            --headers
        
            
        
            --body
        
            
            
            
            
            local r_v12_21 = select(1, ...)
            
            return (function(...)
                --headers
            
                
            
                --body
            
                
                
                
                
                local r_v2_42 = r_v12_21["f"]
                
                return r_v2_42
            end)
        end
        
        
        
        
        
        
        
        return r_v12_19:get()
    end
    
    
    
    
    
    
    
    return (r_v1_6())()
end

r_v1_19(r_v9_13)







print("f")











assert((r_v6_21()) == 5)






