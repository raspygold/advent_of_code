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
connected_to = Set.new([0])
loop do
  previous_size = connected_to.size

  new_connections = Set.new
  connected_to.each do |connection|
    new_connections += connections[connection]
  end

  connected_to += new_connections

  break if previous_size == connected_to.size # No new connections to walk
end

p connected_to.size
