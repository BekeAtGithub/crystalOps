require "socket"

# Define the host and port for the server
HOST = "127.0.0.1"
PORT = 3000

# Create a new TCPServer instance to listen for incoming connections 
server = TCPServer.new(HOST, PORT)

puts "Server is running on #{HOST}:#{PORT}"

# Start an infinite loop to handle incoming connections
loop do
  # Accept an incoming connection
  client = server.accept

  # Print the client's address
  puts "Client connected: #{client.peeraddr}"

  # Handle the client connection in a separate fiber
  spawn do
    # Read data from the client and echo it back
    while data = client.gets
      puts "Received: #{data.strip}"
      client.puts "Echo: #{data}"
    end

    # Close the client connection
    client.close
    puts "Client disconnected"
  end
end
