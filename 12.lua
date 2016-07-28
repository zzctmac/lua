
List = {}

function List.new()
	return {first = 0, last = -1}
end

function List.push(list, value)
	local last = list.last + 1
	list.last = last
	list[last] = value
end

function List.pop(list)
	local last = list.last
	if list.first > last then error("List is empty") end
	local value = list[last]
	list[last] = nil
	list.last = last - 1
	return value
end

function List.getTop(list)
	local last = list.last
	if list.first > last then error("List is empty") end
	local value = list[last]
	return value
end

function List.empty( list )
	if list.first > list.last then 
		return true
	else
		return false
	end
end

function List.print(list)
	for i,v in pairs(list) do 
	print(i,v)
end
end

local data_stack = List.new()

function push_stack_data(num) 
	List.push(data_stack, tonumber(num))
end
local calc_stack = List.new()
function push_stack_calc(calc)
	List.push(calc_stack, calc)
end

local addCalc = '+';
local minusCalc = '-';
local mulCalc = '*';
local divCalc = '/';
local c_t = {
	[addCalc]={[addCalc]=0, [minusCalc]=0, [mulCalc]=0, [divCalc]=0},
	[minusCalc]={[addCalc]=0, [minusCalc]=0, [mulCalc]=0, [divCalc]=0},
	[mulCalc]={[addCalc]=1, [minusCalc]=1, [mulCalc]=0, [divCalc]=0},
	[divCalc]={[addCalc]=1, [minusCalc]=1, [mulCalc]=0, [divCalc]=0}
}

function calc_data() 
	local calc = List.pop(calc_stack)
	local num1 = List.pop(data_stack)
	local num2 = List.pop(data_stack)
	local num = 0
	if calc == '+' then
		num = num1 + num2
	elseif calc == '-' then
			num = num2 - num1
	elseif calc == '*' then
			num = num1 * num2
	else
			num = num2 / num1
	end
	push_stack_data(num)
end

function deal_with()
	if(List.empty(calc_stack) or c_t[List.getTop(calc_stack)][char] == 0) then
		else
			calc_data()
		end
		push_stack_calc(char)
end


function last_deal_with()
	while true do
		if List.empty(calc_stack) then
			break
		end
		calc_data()
	end
end


s = io.read("*line")
local current_num = "" 
len = s:len()
for ic =1,len do 
	char = s:sub(ic,ic)
	if char == '+' or char == '-' or char == '*' or char == '/' then 
		push_stack_data(current_num)
		 current_num = ""
		 deal_with()
		
	else
		current_num = current_num .. char
	end
end
if current_num ~= '' then
	push_stack_data(current_num)
end


last_deal_with()
--print(data_stack, calc_stack)
--List.print(data_stack)
local res = List.pop(data_stack)
print(res)