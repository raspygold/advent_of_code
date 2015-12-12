#!/usr/bin/env ruby
file_path = File.expand_path("../input.txt", __FILE__)
input     = File.read(file_path)

floor = 0
basement_index = nil

input.chars.each.with_index do |char, index|
  case char
  when "("
    floor += 1
  when ")"
    floor -= 1
  end
  basement_index = (index + 1) and break if floor < 0
end

puts basement_index
# => 1797
