local a = function()
    print("g")
end

local w = {}

function w:hee()
    print("hee", self)
end

w.yai = function(a)
    print("yai", a)
end

w:yai()
w:hee()
