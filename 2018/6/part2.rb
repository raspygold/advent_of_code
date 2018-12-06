#!/usr/bin/env ruby

require_relative "../challenge_utils"
include ChallengeUtils

EMPTY = "  "

## SOLUTION BEGINS
def solve(input)
  min_x = min_y = max_x =  max_y = 5 # just to reduce playground
  coords = input.map.with_index do |coord, i|
    coord.match(/(\d+), (\d+)/)[1..-1].map(&:to_i).tap do |c|
      max_x = c[0] if c[0] > max_x
      max_y = c[1] if c[1] > max_y
    end
  end
  grid = (0..max_y).map {|_| [EMPTY]*(max_x+1)} # don't need this really, only using to check size
  coords.each.with_index do |coord, i|
    grid[coord[1]][coord[0]] = label(i)
  end

  close_coords = []
  grid.size.times do |y|
    grid.first.size.times do |x|
      close_coords << [x,y] if coords.map {|c| distance([x,y], c)}.reduce(&:+) < 10_000
    end
  end

  close_coords.size
end

def label(i) #makes some unique labels for the coords
  [65 + i/26, 65 + i%26].map(&:chr).join
end

def distance(to,from) # Manhattan distance
  (to[0]-from[0]).abs + (to[1]-from[1]).abs
end
## SOLUTION ENDS

puts "-"*50, ""

# solve for reals
puts "Solution:", solve(read_input("input"))
