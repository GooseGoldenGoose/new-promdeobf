local function f(t) for k,v in ipairs(t) do return k,v end return 0 end print(f({11,42})) print(f({}))
