#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.readlines(file_path)

connections = Hash.new { |h, k| h[k] = [] }
input.each do |connection|
  connector, connectees = connection.split(" <-> ")
  connector  = connector.to_i
  connectees = connectees.split(", ").map(&:to_i)

  connections[connector] += connectees
  connectees.each { |connectee| connections[connectee] << connector }
end

require 'set'
groups = Set.new

connections_to_check = connections.keys
loop do
  connected_to = Set.new([connections_to_check.first])
  loop do
    previous_size = connected_to.size

    new_connections = Set.new
    connected_to.each do |connection|
      new_connection = connections[connection]
      new_connections += new_connection
      connections_to_check = connections_to_check - new_connection
    end

    connected_to += new_connections

    break if previous_size == connected_to.size # No new connections to walk
  end
  groups << connected_to

  break if connections_to_check.empty?
end

p groups.size
