#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.read(file_path)

lengths = input.strip.split(",").map(&:to_i)

string = (0..255).to_a
current_position = 0

lengths.each.with_index do |length, i|
  rotation = current_position
  string.rotate!(rotation) # move the start of the new loop is at the start of the string
  string = string[0...length].reverse + string[length..-1]

  current_position = (current_position + length + i) % string.size
  string.rotate!(-rotation) # move the start of the new loop back to where it was originally
end

p string[0] * string[1]
