#!/usr/bin/env ruby

require_relative "../challenge_utils"
include ChallengeUtils

## SOLUTION BEGINS
def solve(grid_serial_no)
  fuel_cell_grid = (0..300).map {|y| (0..300).map {|x| fuel_cell_value(x,y, grid_serial_no) } } # we'll ignore index 0 later

  scores = {}
  (1..300).map do |corner_y|
    (1..300).map do |corner_x|
      (1..[20, 300-corner_x, 300-corner_y].min).each do |sq_size|
        ys = (corner_y...corner_y+sq_size).to_a
        xs = (corner_x...corner_x+sq_size).to_a
        scores[[xs.first,ys.first, sq_size]] = xs.product(ys).map do |x,y|
          fuel_cell_grid[y][x]
        end.reduce(&:+)
      end
    end
    print "."
  end
  puts
  scores.sort_by {|k,v| -v}.first[0]
end

def fuel_cell_value(x, y, grid_serial_no)
  rack_id = x + 10
  power_lvl = rack_id * y
  power_lvl += grid_serial_no
  power_lvl *= rack_id
  power_lvl = power_lvl.to_s.chars[-3]&.to_i || 0
  power_lvl -= 5
end
## SOLUTION ENDS

# test scenarios
test(18, [90,269,16])
test(42, [232,251,12])

puts "-"*50, ""

# solve for reals
puts "Solution:", solve(3214)
