#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.readlines(file_path)

valid_triangle_count = 0

input.each.with_index do |line, index|
  sides = line.strip.split(/\s+/).map(&:to_i).sort
  valid_triangle_count += 1 if sides[0..1].reduce(&:+) > sides[2]
end


puts "There are  #{valid_triangle_count} possible listed triangles"
