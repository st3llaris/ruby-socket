require 'socket'

socket = TCPSocket.open('localhost', 8080)

puts "starting client..................."
while message = socket.gets
	puts message.chomp
end

puts "closing client..................."
socket.close
