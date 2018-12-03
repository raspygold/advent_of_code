#!/usr/bin/env ruby

require_relative "../challenge_utils"
include ChallengeUtils

## SOLUTION BEGINS
def solve(input)
  size = 1000
  fabric = (0...size).map {|n| ["."]*size}
  claims = []
  input.each do |claim|
    name, x, y, w, h = claim.match(/#(\d+) @ (\d+),(\d+): (\d+)x(\d+)/)[1..-1].map(&:to_i)
    claims << { name: name.to_s, x: x, y: y, w: w, h: h }
    (y...y+h).each do |row|
      (x...x+w).each do |col|
        fabric[row][col] = fabric[row][col] == "." ? name.to_s : "X"
      end
    end
  end

  claim = nil
  claims.each do |c|
    complete = true
    (c[:y]...c[:y]+c[:h]).each do |row|
      break unless complete
      (c[:x]...c[:x]+c[:w]).each do |col|
        if fabric[row][col] != c[:name].to_s
          complete = false and break
        end
      end
    end
    claim = c and break if complete
  end
  claim[:name].to_i
end
## SOLUTION ENDS

# test scenarios
test([
  "#1 @ 1,3: 4x4",
  "#2 @ 3,1: 4x4",
  "#3 @ 5,5: 2x2"
], 3)

puts "-"*50, ""

# solve for reals
puts "Solution:", solve(read_input("input"))
