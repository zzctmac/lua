require "socket"

function receive(connection)
	connection:settimeout(0)
	local s, status, partial = connection:receive(2^10)
	if status == "timeout" then
			coroutine.yield(connection)
	end
	return s or partial,status
end

function download(host, file)
	local c = assert(socket.connect(host, 80))
	c:send("GET " .. file .. " HTTP/1.0\r\n\r\n")
	local count = 0
	while true do
		local s, status, partial = receive(c, 2^10)
		count = count  + #(s or partial)
		if status == "closed" then break end
	end
	c:close()
	print(file, count)
end

threads = {}

function get(host, file)
	local co = coroutine.create(function() 
		download(host, file)
	end)
	table.insert(threads, co)
end

function dispatch()
	local i = 1
	local connections = {}
	while true do
		if threads[i] == nil then
			if threads[1] == nil then break end
			i = 1
			connections = {}
		end
		local status, res = coroutine.resume(threads[i])
		if not res then
			table.remove(threads, i)
		else
			i = i + 1
			connections[#connections+1]  = res
			if #connections == #threads then
				socket.select(connections)
			end
		end
 	end
end

host = "www.w3.org"

file ="/TR/REC-html32.html"
get(host, file)

file ="/TR/html401/html40.txt"
get(host, file)

file ="/TR/2002/REC-xhtml1-20020801/xhtml1.pdf"
get(host, file)

file ="/TR/2002/REC-DOM-Level-2-Core-20001113/DOM2-Core.txt"
get(host, file)

dispatch()
