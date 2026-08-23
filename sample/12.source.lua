local function thing(value)
    print(value)
    return value
end

local thing2 = thing("table")
thing("after")
return { thing2 }
