#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.read(file_path)

dirs = {
  "n"  => [ 0,    1],
  "s"  => [ 0,   -1],
  "ne" => [ 1,  0.5],
  "nw" => [-1,  0.5],
  "se" => [ 1, -0.5],
  "sw" => [-1, -0.5],
}

next_point     = [0,0]
furthest_point = [0,0]

input.strip.split(",").each do |step|
  move = dirs[step]

  next_point[0] += move[0]
  next_point[1] += move[1]

  furthest_point_distance = furthest_point[0].abs + furthest_point[1].abs * 2
  next_point_distance     = next_point[0].abs     + next_point[1].abs     * 2

  furthest_point = next_point.dup if next_point_distance > furthest_point_distance
end

steps_home = 0
loop do
  move = dirs.min_by do |k, v|
    (furthest_point[0] + v[0]).abs + (furthest_point[1] + v[1]).abs
  end[1]

  furthest_point[0] += move[0]
  furthest_point[1] += move[1]
  steps_home += 1

  break if furthest_point.all?(&:zero?)
end

p steps_home
