#!/usr/bin/env ruby
file_path = File.expand_path("../input.txt", __FILE__)
input     = File.read(file_path)

floor = 0

input.chars.each do |char|
  case char
  when "("
    floor += 1
  when ")"
    floor -= 1
  end
end

puts floor
# => 280
