local count=0 local function values() count=count+1 return 11,42 end local a,b=values() local function read() return a end a=a+3 print(read(),b,count)
