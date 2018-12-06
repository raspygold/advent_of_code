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
  grid = (0..max_y).map {|_| ["  "]*max_x}
  coords.each.with_index do |coord, i|
    grid[coord[1]][coord[0]] = label(i)
  end

  areas = Hash.new(1) # starts with itself
  grid.size.times do |y|
    grid.first.size.times do |x|
      closest = closest_point([x,y], coords)
      if closest && grid[y][x] == EMPTY
        point = grid[closest[1]][closest[0]]
        grid[y][x] = point.downcase 
        areas[point] += 1
      end
    end
  end

  bounded_coords = coords.reject {|c| infinite?(c, coords, grid)}
  bounded_points = bounded_coords.map {|c| grid[c[1]][c[0]]}

  areas.select {|k,_| bounded_points.include?(k)}.values.max
end

def label(i) #makes some unique labels for the coords
  [65 + i/26, 65 + i%26].map(&:chr).join
end

def closest_point(to, points)
  distances = points.inject(Hash.new {|hsh, key| hsh[key] = []}) do |hsh, point|
    hsh[distance(to,point)] << point
    hsh
  end
  closest_coords = distances.sort.first[1]
  closest_coords.one? ? closest_coords.first : nil
end

def distance(to,from) # Manhattan distance
  (to[0]-from[0]).abs + (to[1]-from[1]).abs
end

def infinite?(point, points, grid)
  other_points = points.dup.tap{|p| p.delete(point)}
  distant_modifier = 100
  far_top = [point[0],point[1]-distant_modifier]
  far_bot = [point[0],point[1]+distant_modifier]
  far_lef = [point[0]-distant_modifier,point[1]]
  far_rig = [point[0]+distant_modifier,point[1]]
  checks = [
    other_points.all? {|other_point| distance(point, far_top) < distance(other_point, far_top)},
    other_points.all? {|other_point| distance(point, far_bot) < distance(other_point, far_bot)},
    other_points.all? {|other_point| distance(point, far_lef) < distance(other_point, far_lef)},
    other_points.all? {|other_point| distance(point, far_rig) < distance(other_point, far_rig)},
].any?
end

def pm(grid)
  puts "__"*(grid.first.size+1)
  grid.each {|r| print "|"; r.each {|c| print c }; puts "|"}
  puts "__"*(grid.first.size+1)
end
## SOLUTION ENDS

# test scenarios
test(["1, 1",
      "1, 6",
      "8, 3",
      "3, 4",
      "5, 5",
      "8, 9"], 17)

puts "-"*50, ""

# solve for reals
puts "Solution:", solve(read_input("input"))
