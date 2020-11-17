require 'socket'
require 'pry'

class Server
  def initialize(socket_address, socket_port)
    @server_socket = TCPServer.open(socket_port, socket_address)

    @connections_details = Hash.new
    @connected_clients = Hash.new

    @connections_details[:server] = @server_socket
    @connections_details[:clients] = @connected_clients

    puts 'starting server.........'
    run
    puts 'server started'
  end

  def run
    loop {
      client_connection = @server_socket.accept
      Thread.start(client_connection) do |conn|
        conn_name = conn.gets.chomp.to_sym
        if(@connections_details[:clients][conn_name] != nil)
          conn.puts 'username already exists'
          conn.puts 'quitting.......'
          conn.kill self
        end

      puts "connection established #{conn_name} => #{conn}"
      @connections_details[:clients][conn_name] = conn
      conn.puts "connection established successfully #{conn_name} => #{conn}. enjoy chatting!"

      establish_chatting(conn_name, conn)
    end
  }.join
  end

  def establish_chatting(username, connection)
    loop do
      message = connection.gets.chomp
      puts @connections_details[:clients]
      (@connections_details[:clients]).keys.each do |client|
        @connections_details[:clients][client].puts "#{username}: #{message}"
      end
    end
  end
end

Server.new( 8080, 'localhost' )
