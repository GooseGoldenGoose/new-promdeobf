local count=0 local function value() count=count+1 return {count} end local function f(enabled) if enabled then local t=value() print(t[1],t[1],t==t) end print(count) end f(true) f(false)
