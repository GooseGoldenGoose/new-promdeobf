local count=0 local function values() count=count+1 return 11,42 end local t={9,values()} print(t[1],t[2],t[3],count)
