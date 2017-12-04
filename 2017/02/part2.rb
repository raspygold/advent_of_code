#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.readlines(file_path)

spreadsheet = input.map do |line|
  line.strip.split(" ").map(&:to_i)
end

checksum = 0
spreadsheet.map do |row|
  row.each.with_index do |a, i|
    row.each.with_index do |b, j|
      next unless j > i

      smaller, bigger = [a,b].sort
      checksum += bigger / smaller if bigger % smaller == 0
    end
  end

end

puts checksum.inspect
