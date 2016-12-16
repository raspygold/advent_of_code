#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.read(file_path)

disc_size = 272
disc_contents = input.strip.split("")

# Generate disc contents
loop do
  a = disc_contents.dup
  b = a.dup
  b.reverse!
  b = b.map { |c| c == "1" ? "0" : "1" }

  disc_contents = (a + ["0"] + b)[0...disc_size]

  break if disc_contents.length == disc_size
end

# Checksum disc contents
checksum = disc_contents
loop do
  checksum = checksum.each_slice(2).with_object([]) do |(a,b), arr|
    arr << (a == b ? "1" : "0")
  end

  break if checksum.length.odd?
end

puts "", "The correct checksum is: #{checksum.join}"
