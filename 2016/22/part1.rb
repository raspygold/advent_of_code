#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.readlines(file_path)

Node = Struct.new(:x, :y, :size, :used, :available, :used_percentage)

nodes = []
input.each do |node_df|
  rgx = /\/dev\/grid\/node-x(\d+)-y(\d+)\s+(\d+)T\s+(\d+)T\s+(\d+)T\s+(\d+)%/
  matches = rgx.match(node_df)

  nodes << Node.new(*matches.captures.map(&:to_i)) if matches
end

viable_node_pairs = 0

nodes.each do |node_a|
  nodes.each do |node_b|
    viable_node_pairs += 1 if node_a != node_b && node_a.used > 0 && node_a.used <= node_b.available
  end
end

puts "", "The number of viable pairs of nodes is: #{viable_node_pairs}"
