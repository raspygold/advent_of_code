#!/usr/bin/env ruby

require_relative "../challenge_utils"
include ChallengeUtils

## SOLUTION BEGINS
def solve(input)
  size = 1000
  fabric = (0...size).map {|n| ["."]*size}
  input.each do |claim|
    name, x, y, w, h = claim.match(/#(\d+) @ (\d+),(\d+): (\d+)x(\d+)/)[1..-1].map(&:to_i)
    (y...y+h).each do |row|
      (x...x+w).each do |col|
        fabric[row][col] = fabric[row][col] == "." ? name.to_s : "X"
      end
    end
  end

  fabric.inject(0) {|rowtot, row| 
    rowtot + row.inject(0) {|coltot, col,| 
      coltot + (col == "X" ? 1 : 0)}}
end
## SOLUTION ENDS

# test scenarios
test([
  "#1 @ 1,3: 4x4",
  "#2 @ 3,1: 4x4",
  "#3 @ 5,5: 2x2"
], 4)

puts "-"*50, ""

# solve for reals
puts "Solution:", solve(read_input("input"))
