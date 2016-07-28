list = nil

list = {next = list, value=1}

list = {next = list , value = 2}

local l = list 
while l do 
	print(l.value)
	l = l.next
end