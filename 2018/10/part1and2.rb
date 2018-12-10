#!/usr/bin/env ruby

require_relative "../challenge_utils"
include ChallengeUtils

## SOLUTION BEGINS
def solve(input)
  points = input.inject([]) do |arr, str|
    px,py,vx,vy = str.scan(/-?\d+/).map(&:to_i)
    arr << { position: [px,py], velocity: [vx,vy] }
    arr
  end
  seconds = 0

  loop do 
    points.each do |point|
      point[:position] = [point[:position][0]+point[:velocity][0], point[:position][1]+point[:velocity][1]]
    end
    seconds+=1
    draw_points(points, seconds) #if points.all? {|point| point[:position].all?{|coord| coord.positive?} }
  end
end
def draw_points(points, seconds)
  min_x = points.min_by {|point| point[:position][0]}[:position][0]
  max_x = points.max_by {|point| point[:position][0]}[:position][0]
  min_y = points.min_by {|point| point[:position][1]}[:position][1]
  max_y = points.max_by {|point| point[:position][1]}[:position][1]
  return unless [max_x - min_x, max_y - min_y].all? {|n| (0...65).include?(n)} 

  light_positions = points.map {|point| point[:position]}
  p [max_x, max_y, seconds]

  puts
  (min_y..max_y).each do |y| 
    (min_x..max_x).each do |x| 
      print light_positions.include?([x,y]) ? "█" : " "
    end
    puts
  end
  puts
  # eyeballs used to get the answer
end
## SOLUTION ENDS

# test scenarios
# test(%Q{
# position=< 9,  1> velocity=< 0,  2>
# position=< 7,  0> velocity=<-1,  0>
# position=< 3, -2> velocity=<-1,  1>
# position=< 6, 10> velocity=<-2, -1>
# position=< 2, -4> velocity=< 2,  2>
# position=<-6, 10> velocity=< 2, -2>
# position=< 1,  8> velocity=< 1, -1>
# position=< 1,  7> velocity=< 1,  0>
# position=<-3, 11> velocity=< 1, -2>
# position=< 7,  6> velocity=<-1, -1>
# position=<-2,  3> velocity=< 1,  0>
# position=<-4,  3> velocity=< 2,  0>
# position=<10, -3> velocity=<-1,  1>
# position=< 5, 11> velocity=< 1, -2>
# position=< 4,  7> velocity=< 0, -1>
# position=< 8, -2> velocity=< 0,  1>
# position=<15,  0> velocity=<-2,  0>
# position=< 1,  6> velocity=< 1,  0>
# position=< 8,  9> velocity=< 0, -1>
# position=< 3,  3> velocity=<-1,  1>
# position=< 0,  5> velocity=< 0, -1>
# position=<-2,  2> velocity=< 2,  0>
# position=< 5, -2> velocity=< 1,  2>
# position=< 1,  4> velocity=< 2,  1>
# position=<-2,  7> velocity=< 2, -2>
# position=< 3,  6> velocity=<-1, -1>
# position=< 5,  0> velocity=< 1,  0>
# position=<-6,  0> velocity=< 2,  0>
# position=< 5,  9> velocity=< 1, -2>
# position=<14,  7> velocity=<-2,  0>
# position=<-3,  6> velocity=< 2, -1>
# }.strip.split("\n"), "HI")

puts "-"*50, ""

# solve for reals
puts "Solution:", solve(read_input("input"))
