#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.read(file_path)

directions       = { N: 0, E: 0, S: 0, W: 0 }
direction_adjust = { "R" => 1, "L" => -1}
direction_index = 0
visited_coords  = []
blocks_moved    = 0

input.split(", ").each do |movement|
  dir, blocks = movement[0], movement[1..-1].to_i
  direction_index += direction_adjust[dir]

  if direction_index < 0
    direction_index = directions.size - 1
  elsif direction_index > directions.size - 1
    direction_index = 0
  end

  blocks.times do
    directions[directions.keys[direction_index]] += 1
    visited_coords << [directions[:N] - directions[:S], directions[:E] - directions[:W]]
    blocks_moved += 1

    if visited_coords.uniq.size < blocks_moved # duplicate coords detected
      blocks = visited_coords.last.map(&:abs).reduce(&:+)
      puts "The first location I visited twice is #{blocks} blocks away"
      exit
    end
  end

end
