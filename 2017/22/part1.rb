#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.readlines(file_path)
require 'set'

CLEAN_NODE = "."
INFECTED_NODE = "#"

carrier_directions = %i{ N E S W }
movements = {
  N: [-1,0],
  E: [0,1],
  S: [1,0],
  W: [0,-1],
}
map = input.map { |row| row.strip.chars }
# expand map
500.times do
  original_map_size = map.size
  # extend rows
  map.unshift(Array.new(original_map_size) {CLEAN_NODE})
  map << Array.new(original_map_size) {CLEAN_NODE}
  # extend columns
  map.each do |row|
    row.unshift(CLEAN_NODE)
    row << CLEAN_NODE
  end
end

puts "Map extended"

nodes_infected = []
# start in the middle
carrier_coord = [map.size / 2, map.first.size / 2] # [row, col]
10000.times do
  case map[carrier_coord[0]][carrier_coord[1]]
  when INFECTED_NODE
    carrier_directions.rotate!
    map[carrier_coord[0]][carrier_coord[1]] = CLEAN_NODE
  when CLEAN_NODE
    carrier_directions.rotate!(-1)
    map[carrier_coord[0]][carrier_coord[1]] = INFECTED_NODE
    nodes_infected << [carrier_coord[0], carrier_coord[1]]
  end

  carrier_coord = carrier_coord.map.with_index do |coord, i|
    coord + movements[carrier_directions.first][i]
  end
end

puts nodes_infected.size
