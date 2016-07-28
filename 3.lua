require "socket"

host = "www.w3.org"

function receive(connection)
	return connection:receive(2^10)
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

file ="/TR/REC-html32.html"
download(host, file)

file ="/TR/html401/html40.txt"
download(host, file)

file ="/TR/2002/REC-xhtml1-20020801/xhtml1.pdf"
download(host, file)

file ="/TR/2002/REC-DOM-Level-2-Core-20001113/DOM2-Core.txt"
download(host, file)