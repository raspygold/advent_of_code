#!/usr/bin/env ruby
file_path = File.expand_path("../input.txt", __FILE__)
input     = File.readlines(file_path)

total_area = 0

input.each do |dims|
  l, w, h    = dims.split("x").map(&:to_i)
  uniq_areas = [l*w, w*h, h*l]
  areas      = uniq_areas.map { |v| v*2 }

  total_area += areas.reduce(&:+) + uniq_areas.min
end

puts total_area
# => 1586300
