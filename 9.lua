List = {}

function List.new ()
	return {first = 0, last =-1}
end

function List.pushfirst(list, value)
	local first = list.first - 1
	list.first = first
	list[first] = value
end

l = List.new()

List.pushfirst(l, 1)

for i,v in pairs(l) do
	print(i,v)
end