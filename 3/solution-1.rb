#!/usr/bin/env ruby
file_path = File.expand_path("../input.txt", __FILE__)
input     = File.read(file_path)

require 'set'

delivered_coords = Set.new

x = y = 0
delivered_coords << [x, y]

input.chars.each do |char|
  case char
  when "^"
    y += 1
  when ">"
    x += 1
  when "v"
    y -= 1
  when "<"
    x -= 1
  end

  delivered_coords << [x, y]
end

puts delivered_coords.count
# => 2592
