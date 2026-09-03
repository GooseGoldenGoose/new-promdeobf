local v1 = 1
local v2 = 1
local v3 = 1
print(v1, v2, v3)
local v4 = ((v1 and v2) or (v3 or (v3 or (v3 or (v1 and v3)))))
print((v4 and v1))
