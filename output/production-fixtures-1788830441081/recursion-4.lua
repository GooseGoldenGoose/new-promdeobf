local function f(n) if n == 0 then return 0 end return f(n-1)+1 end print(f(4))
