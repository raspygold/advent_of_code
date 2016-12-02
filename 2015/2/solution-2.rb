#!/usr/bin/env ruby
file_path = File.expand_path("../input.txt", __FILE__)
input     = File.readlines(file_path)

total_ribbon = 0

input.each do |dims|
  l, w, h = dims.split("x").map(&:to_i)
  sides   = [l, w, h]

  total_ribbon += (sides.min(2).reduce(&:+) * 2) + sides.reduce(&:*)
end

puts total_ribbon
# => 3737498
