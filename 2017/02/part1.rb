#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.readlines(file_path)

spreadsheet = input.map do |line|
  line.strip.split(" ").map(&:to_i)
end

checksum = 0
spreadsheet.map do |row|
  checksum += row.max - row.min
end

puts checksum.inspect
