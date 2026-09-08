local count=0 local function values() count=count+1 return 11,42 end local function combine(a,b) return a+b end local t={combine(values())} print(t[1],count)
