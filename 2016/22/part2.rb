#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.readlines(file_path)

def display_grid(node_array)
  target_node = [0,0]
  goal_data   = [node_array.first.last.x, node_array.first.last.y]
  node_array.each do |row|
    row.each.with_index do |server, i|
      block = if server.x == goal_data[0] && server.y == goal_data[1]
        "G"
      elsif server.x == target_node[0] && server.y == target_node[1]
        "T"
      elsif server.used.zero?
        "_"
      elsif server.used > 400
        "#"
      else
        "."
      end
      print block # [#{server.used}/#{server.size}]
    end
    puts
  end
end

Node = Struct.new(:x, :y, :size, :used, :available, :used_percentage)

nodes = []
input.each do |node_df|
  rgx = /\/dev\/grid\/node-x(\d+)-y(\d+)\s+(\d+)T\s+(\d+)T\s+(\d+)T\s+(\d+)%/
  matches = rgx.match(node_df)

  nodes << Node.new(*matches.captures.map(&:to_i)) if matches
end

node_array = Array.new(nodes.max_by(&:y).y + 1) { Array.new { nodes.max_by(&:x).x + 1 } }
nodes.each { |node| node_array[node.y][node.x] = node }

display_grid(node_array)

puts "", "The fewest number of steps required to move your goal data to node-x0-y0 is: 261" # Answer from manual calculation of printed grid
