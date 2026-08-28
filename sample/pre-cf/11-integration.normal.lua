vm = function(state, args, upvalues, gcProxy)
    local r1, r2, ReturnVal
    while state do
        if state == 1 then
            r1 = 1
            r2 = r1
            ReturnVal = { r2 }
            state = nil
        end
    end
    state = #gcProxy
    return unpack(ReturnVal)
end
root = createClosure(1, {})