local total = 0

local function worker1(x)
    local value = x + 1
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    if value > 2 then
        total = total + 1
    else
        total = total - 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker2(x, unused2)
    local value = x + 2
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    if value > 3 then
        total = total + 2
    else
        total = total - 2
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker3(x, unused2, unused3)
    local value = x + 3
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    if value > 4 then
        total = total + 3
    else
        total = total - 3
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker4(x, unused2, unused3, unused4)
    local value = x + 4
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    if value > 5 then
        total = total + 4
    else
        total = total - 4
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker5(x, unused2, unused3, unused4, unused5)
    local value = x + 5
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    if value > 6 then
        total = total + 5
    else
        total = total - 5
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker6(x)
    local value = x + 6
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    if value > 7 then
        total = total + 6
    else
        total = total - 6
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker7(x, unused2)
    local value = x + 7
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    if value > 8 then
        total = total + 7
    else
        total = total - 7
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker8(x, unused2, unused3)
    local value = x + 8
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    if value > 9 then
        total = total + 8
    else
        total = total - 8
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker9(x, unused2, unused3, unused4)
    local value = x + 9
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    if value > 10 then
        total = total + 9
    else
        total = total - 9
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker10(x, unused2, unused3, unused4, unused5)
    local value = x + 10
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    if value > 11 then
        total = total + 10
    else
        total = total - 10
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker11(x)
    local value = x + 11
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    if value > 12 then
        total = total + 11
    else
        total = total - 11
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker12(x, unused2)
    local value = x + 12
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    if value > 13 then
        total = total + 12
    else
        total = total - 12
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker13(x, unused2, unused3)
    local value = x + 13
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    if value > 14 then
        total = total + 13
    else
        total = total - 13
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker14(x, unused2, unused3, unused4)
    local value = x + 14
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    if value > 15 then
        total = total + 14
    else
        total = total - 14
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker15(x, unused2, unused3, unused4, unused5)
    local value = x + 15
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    if value > 16 then
        total = total + 15
    else
        total = total - 15
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker16(x)
    local value = x + 16
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    if value > 17 then
        total = total + 16
    else
        total = total - 16
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker17(x, unused2)
    local value = x + 17
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    if value > 18 then
        total = total + 17
    else
        total = total - 17
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker18(x, unused2, unused3)
    local value = x + 18
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    if value > 19 then
        total = total + 18
    else
        total = total - 18
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker19(x, unused2, unused3, unused4)
    local value = x + 19
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    if value > 20 then
        total = total + 19
    else
        total = total - 19
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker20(x, unused2, unused3, unused4, unused5)
    local value = x + 20
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    if value > 21 then
        total = total + 20
    else
        total = total - 20
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker21(x)
    local value = x + 21
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    if value > 22 then
        total = total + 21
    else
        total = total - 21
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker22(x, unused2)
    local value = x + 22
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    if value > 23 then
        total = total + 22
    else
        total = total - 22
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker23(x, unused2, unused3)
    local value = x + 23
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    if value > 24 then
        total = total + 23
    else
        total = total - 23
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker24(x, unused2, unused3, unused4)
    local value = x + 24
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    if value > 25 then
        total = total + 24
    else
        total = total - 24
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker25(x, unused2, unused3, unused4, unused5)
    local value = x + 25
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    if value > 26 then
        total = total + 25
    else
        total = total - 25
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker26(x)
    local value = x + 26
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    if value > 27 then
        total = total + 26
    else
        total = total - 26
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker27(x, unused2)
    local value = x + 27
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    if value > 28 then
        total = total + 27
    else
        total = total - 27
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker28(x, unused2, unused3)
    local value = x + 28
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    if value > 29 then
        total = total + 28
    else
        total = total - 28
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker29(x, unused2, unused3, unused4)
    local value = x + 29
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    if value > 30 then
        total = total + 29
    else
        total = total - 29
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker30(x, unused2, unused3, unused4, unused5)
    local value = x + 30
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    if value > 31 then
        total = total + 30
    else
        total = total - 30
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker31(x)
    local value = x + 31
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    if value > 32 then
        total = total + 31
    else
        total = total - 31
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker32(x, unused2)
    local value = x + 32
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    if value > 33 then
        total = total + 32
    else
        total = total - 32
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker33(x, unused2, unused3)
    local value = x + 33
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    if value > 34 then
        total = total + 33
    else
        total = total - 33
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker34(x, unused2, unused3, unused4)
    local value = x + 34
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    if value > 35 then
        total = total + 34
    else
        total = total - 34
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker35(x, unused2, unused3, unused4, unused5)
    local value = x + 35
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    if value > 36 then
        total = total + 35
    else
        total = total - 35
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker36(x)
    local value = x + 36
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    if value > 37 then
        total = total + 36
    else
        total = total - 36
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker37(x, unused2)
    local value = x + 37
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    if value > 38 then
        total = total + 37
    else
        total = total - 37
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker38(x, unused2, unused3)
    local value = x + 38
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    if value > 39 then
        total = total + 38
    else
        total = total - 38
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker39(x, unused2, unused3, unused4)
    local value = x + 39
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    if value > 40 then
        total = total + 39
    else
        total = total - 39
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker40(x, unused2, unused3, unused4, unused5)
    local value = x + 40
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    if value > 41 then
        total = total + 40
    else
        total = total - 40
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker41(x)
    local value = x + 41
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    if value > 42 then
        total = total + 41
    else
        total = total - 41
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker42(x, unused2)
    local value = x + 42
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    if value > 43 then
        total = total + 42
    else
        total = total - 42
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker43(x, unused2, unused3)
    local value = x + 43
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    if value > 44 then
        total = total + 43
    else
        total = total - 43
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker44(x, unused2, unused3, unused4)
    local value = x + 44
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    if value > 45 then
        total = total + 44
    else
        total = total - 44
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker45(x, unused2, unused3, unused4, unused5)
    local value = x + 45
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker46(x)
    local value = x + 46
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker47(x, unused2)
    local value = x + 47
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker48(x, unused2, unused3)
    local value = x + 48
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker49(x, unused2, unused3, unused4)
    local value = x + 49
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker50(x, unused2, unused3, unused4, unused5)
    local value = x + 50
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker51(x)
    local value = x + 51
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker52(x, unused2)
    local value = x + 52
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker53(x, unused2, unused3)
    local value = x + 53
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker54(x, unused2, unused3, unused4)
    local value = x + 54
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker55(x, unused2, unused3, unused4, unused5)
    local value = x + 55
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker56(x)
    local value = x + 56
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker57(x, unused2)
    local value = x + 57
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker58(x, unused2, unused3)
    local value = x + 58
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker59(x, unused2, unused3, unused4)
    local value = x + 59
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker60(x, unused2, unused3, unused4, unused5)
    local value = x + 60
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker61(x)
    local value = x + 61
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker62(x, unused2)
    local value = x + 62
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker63(x, unused2, unused3)
    local value = x + 63
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker64(x, unused2, unused3, unused4)
    local value = x + 64
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker65(x, unused2, unused3, unused4, unused5)
    local value = x + 65
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker66(x)
    local value = x + 66
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker67(x, unused2)
    local value = x + 67
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker68(x, unused2, unused3)
    local value = x + 68
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker69(x, unused2, unused3, unused4)
    local value = x + 69
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker70(x, unused2, unused3, unused4, unused5)
    local value = x + 70
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker71(x)
    local value = x + 71
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker72(x, unused2)
    local value = x + 72
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker73(x, unused2, unused3)
    local value = x + 73
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker74(x, unused2, unused3, unused4)
    local value = x + 74
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker75(x, unused2, unused3, unused4, unused5)
    local value = x + 75
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker76(x)
    local value = x + 76
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker77(x, unused2)
    local value = x + 77
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker78(x, unused2, unused3)
    local value = x + 78
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker79(x, unused2, unused3, unused4)
    local value = x + 79
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker80(x, unused2, unused3, unused4, unused5)
    local value = x + 80
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker81(x)
    local value = x + 81
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker82(x, unused2)
    local value = x + 82
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker83(x, unused2, unused3)
    local value = x + 83
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker84(x, unused2, unused3, unused4)
    local value = x + 84
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker85(x, unused2, unused3, unused4, unused5)
    local value = x + 85
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker86(x)
    local value = x + 86
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker87(x, unused2)
    local value = x + 87
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker88(x, unused2, unused3)
    local value = x + 88
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker89(x, unused2, unused3, unused4)
    local value = x + 89
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker90(x, unused2, unused3, unused4, unused5)
    local value = x + 90
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker91(x)
    local value = x + 91
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker92(x, unused2)
    local value = x + 92
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker93(x, unused2, unused3)
    local value = x + 93
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker94(x, unused2, unused3, unused4)
    local value = x + 94
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker95(x, unused2, unused3, unused4, unused5)
    local value = x + 95
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker96(x)
    local value = x + 96
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker97(x, unused2)
    local value = x + 97
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker98(x, unused2, unused3)
    local value = x + 98
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker99(x, unused2, unused3, unused4)
    local value = x + 99
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker100(x, unused2, unused3, unused4, unused5)
    local value = x + 100
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker101(x)
    local value = x + 101
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker102(x, unused2)
    local value = x + 102
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker103(x, unused2, unused3)
    local value = x + 103
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker104(x, unused2, unused3, unused4)
    local value = x + 104
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker105(x, unused2, unused3, unused4, unused5)
    local value = x + 105
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker106(x)
    local value = x + 106
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker107(x, unused2)
    local value = x + 107
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker108(x, unused2, unused3)
    local value = x + 108
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker109(x, unused2, unused3, unused4)
    local value = x + 109
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker110(x, unused2, unused3, unused4, unused5)
    local value = x + 110
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker111(x)
    local value = x + 111
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker112(x, unused2)
    local value = x + 112
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker113(x, unused2, unused3)
    local value = x + 113
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker114(x, unused2, unused3, unused4)
    local value = x + 114
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local function worker115(x, unused2, unused3, unused4, unused5)
    local value = x + 115
    if value % 2 == 0 then
        total = total + value
    else
        total = total + 1
    end
    local i = 0
    while i < 2 do
        total = total + i
        i = i + 1
    end
    return total
end

local a = worker1(1)
local b = worker58(2)
local c = worker115(3)
print("stress", a, b, c, total)
