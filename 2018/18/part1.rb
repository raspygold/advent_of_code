#!/usr/bin/env ruby

require_relative "../challenge_utils"
include ChallengeUtils

## SOLUTION BEGINS
TREE = "|"
MILL = "#"
OPEN = "."
def solve(input)
  area = input.map(&:chars)

  10.times do
    area_evolution = Array.new(area.size) {Array.new(area.size)}
    area_evolution.size.times do |y|
      area_evolution.size.times do |x|
        neighbours = [
          [x, y-1],
          [x+1, y],
          [x, y+1],
          [x-1, y],
          [x-1, y+1],
          [x+1, y-1],
          [x-1, y-1],
          [x+1, y+1],
        ].select do |x, y|
          [x,y].all? {|n| (0...area_evolution.size).include?(n)}
        end
        neighbour_vals = neighbours.map {|x,y| area[y][x]}
        area_evolution[y][x] = case area[y][x]
        when TREE
          neighbour_vals.count {|c| c == MILL} > 2 ? MILL : TREE
        when MILL
          neighbour_vals.count {|c| c == TREE} > 0 && neighbour_vals.count {|c| c == MILL} > 0 ? MILL : OPEN
        when OPEN
          neighbour_vals.count {|c| c == TREE} > 2 ? TREE : OPEN
        end
      end
    end
    area = area_evolution
  end

  summed_areas = area.inject(Hash.new(0)) do |hsh, row|
    hsh[MILL] += row.count {|c| c == MILL}
    hsh[TREE] += row.count {|c| c == TREE}
    hsh
  end
  summed_areas.values.reduce(&:*)
end
## SOLUTION ENDS

# test scenarios
test(%(
.#.#...|#.
.....#|##|
.|..|...#.
..|#.....#
#.#|||#|#|
...#.||...
.|....|...
||...#|.#|
|.||||..|.
...#.|..|.
).strip.split("\n"), 1147)

puts "-"*50, ""

# solve for reals
puts "Solution:", solve(read_input("input"))
