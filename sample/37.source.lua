print("mutate-for-start")
for i = 1, 3 do
    print("mutate-before", i)
    i = i + 10
    print("mutate-after", i)
end
print("mutate-for-end")
