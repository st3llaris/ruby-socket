require 'socket'

puts 'starting server...................'
server = TCPServer.open(8080)
puts 'server started...................'
loop {
	client_connection = server.accept
	client_connection.puts(Time.now)
	client_connection.puts("closing connection with #{client_connection}")
	client_connection.close
}
