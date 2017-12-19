#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.readlines(file_path)

def move(location, move)
  [location, move].transpose.map { |arr| arr.reduce(&:+) }
end

require 'set'
require 'matrix'

EMPTY = " "
network_map = Matrix[*input.map { |row| row.chomp("\n").chars }]
visited = Set.new

letters_passed = [] 
direction_movements = {
  :N => [-1,0],
  :E => [0,1],
  :S => [1,0],
  :W => [0,-1],
}

location = network_map.index("|")
current_direction = :S

loop do
  location = move(location, direction_movements[current_direction])
  visited << location

  location_value = network_map[*location]

  case location_value
  when "+"
    potential_directions = direction_movements.select do |direction, move|
      potential_move       = move(location, move)
      move_within_network  = potential_move.all? { |x| x.between?(0, network_map.row_count-1) } # within the network map
      move_not_visited     = !visited.include?(potential_move)
      move_not_empty       = network_map[*potential_move] != EMPTY

      move_within_network && move_not_visited && move_not_empty
    end
    current_direction = potential_directions.keys.first
  when /\w/
    letters_passed << location_value
  end

  break if network_map[*location] == EMPTY # if there's nowhere else to go we're done
end

puts letters_passed.join
