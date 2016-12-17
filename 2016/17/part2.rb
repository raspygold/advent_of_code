#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
$input     = File.read(file_path).strip

require 'digest'

def determine_next_moves(path, position)
  print "."

  if position == [3,3]
    return path
  end

  digest = Digest::MD5.hexdigest("#{$input}#{path}")
  up, down, left, right = digest.split("")[0..3]
  [up, down, left, right].map.with_index do |value, i|
    if value =~ /[b-z]/
      position_modifier = [[0,-1], [0,1], [-1,0], [1,0]][i]
      new_position = [position[0] + position_modifier[0], position[1] + position_modifier[1]]
      new_path = path + ["U", "D", "L", "R"][i]

      if new_position.all? { |c| c.between?(0, 3) } # Inside the grid
        determine_next_moves(new_path, new_position)
      end
    end
  end.compact
end

shortest_path = determine_next_moves("", [0,0]).flatten.compact.max_by(&:length).length

puts "", "The longest path to the vault is: #{shortest_path}"
