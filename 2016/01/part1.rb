#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.read(file_path)

directions       = { N: 0, E: 0, S: 0, W: 0 }
direction_adjust = { "R" => 1, "L" => -1}
direction_index = 0

input.split(", ").each do |movement|
  dir, blocks = movement[0], movement[1..-1]
  direction_index += direction_adjust[dir]

  if direction_index < 0
    direction_index = directions.size - 1
  elsif direction_index > directions.size - 1
    direction_index = 0
  end

  directions[directions.keys[direction_index]] += blocks.to_i
end

coords = [directions[:N] - directions[:S], directions[:E] - directions[:W]]
blocks = coords.map(&:abs).reduce(&:+)

puts "Easter Bunny HQ is #{blocks} blocks away."
