#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.readlines(file_path)

valid_triangle_count = 0

parsed_input = input.map do |row|
  row.strip.split(/\s+/).map(&:to_i)
end
parsed_input.transpose.each do |triangle_set|
  triangle_set.each_slice(3) do |triangle_sides|
    triangle_sides.sort!
    valid_triangle_count += 1 if triangle_sides[0..1].reduce(&:+) > triangle_sides[2]
  end
end



puts "There are  #{valid_triangle_count} possible listed triangles"
