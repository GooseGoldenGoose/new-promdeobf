do local valid = true;
    local gmatch = string.gmatch;
    local err = function() error("Tamper Detected!") end;

    local pcallIntact2 = false;
    local pcallIntact = pcall(function()
        pcallIntact2 = true;
    end) and pcallIntact2;

    local random = math.random;
    local tblconcat = table.concat;
    local unpkg = table and table.unpack or unpack;
    local n = random(3, 65);
    local acc1 = 0;
    local acc2 = 0;
    local pcallRet = {pcall(function() local a = 7348123 - "rLkPzM" ^ 1192387 return "JwQnVe" / a; end)};
    local origMsg = pcallRet[2];
    local line = tonumber(gmatch(tostring(origMsg), ':(%d*):')());
    for i = 1, n do
        local len = math.random(1, 100);
        local n2 = random(0, 255);
        local pos = random(1, len);
        local shouldErr = random(1, 2) == 1;
        local msg = origMsg:gsub(':(%d*):', ':' .. tostring(random(0, 10000)) .. ':');
        local arr = {pcall(function()
            if random(1, 2) == 1 or i == n then
                local line2 = tonumber(gmatch(tostring(({pcall(function() local a = 4920137 - "tYxBqR" ^ 831271 return "HdMvKs" / a; end)})[2]), ':(%d*):')());
                valid = valid and line == line2;
            end
            if shouldErr then
                error(msg, 0);
            end
            local arr = {};
            for i = 1, len do
                arr[i] = random(0, 255);
            end
            arr[pos] = n2;
            return unpkg(arr);
        end)};
        if shouldErr then
            valid = valid and arr[1] == false and arr[2] == msg;
        else
            valid = valid and arr[1];
            acc1 = (acc1 + arr[pos + 1]) % 256;
            acc2 = (acc2 + n2) % 256;
        end
    end
    valid = valid and acc1 == acc2;

    if valid then 
    else
        repeat 
            return (function()
                while true do
                    l1, l2 = l2, l1;
                    err();
                end
            end)(); 
        until true;
        while true do
            l2 = random(1, 6);
            if l2 > 2 then
                l2 = tostring(l1);
            else
                l1 = l2;
            end
        end
        return;
    end
end

-- Anti Function Arg Hook
local obj = setmetatable({}, {
    __tostring = err,
});
obj[math.random(1, 100)] = obj;
(function() end)(obj);

repeat until valid;
