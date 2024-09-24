### TCP SERVER - check on line 35 for client.
require "socket"

# Create a TCP server that listens on localhost:1234
server = TCPServer.new("localhost", 1234)

puts "Server is running on localhost:1234..."

# Start accepting client connections
loop do
  client = server.accept

  # Handle client connections in a separate fiber
  spawn do
    puts "Client connected: #{client.peeraddr}"

    # Send a welcome message to the client
    client.puts "Hello from Crystal server!"

    # Read data from the client
    while line = client.gets
      puts "Received from client: #{line}"

      # Echo the data back to the client
      client.puts "Echo: #{line}"
    end

    # Close the client connection
    client.close
    puts "Client disconnected."
  end
end


### TCP client
require "socket"

# Connect to the TCP server on localhost:1234
client = TCPSocket.new("localhost", 1234)

# Read the welcome message from the server
puts client.gets

# Send a message to the server
client.puts "Hello from Crystal client!"

# Read the echoed message from the server
puts client.gets

# Close the connection
client.close
