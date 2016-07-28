local authors = {}
function Entry(b) authors[#authors+1] = b.author end
dofile("data")

for k,v in pairs(authors) do print(k,v) end