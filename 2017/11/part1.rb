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

end_point = [0,0]
input.strip.split(",").each do |step|
  move = dirs[step]

  end_point[0] += move[0]
  end_point[1] += move[1]
end

steps_home = 0
loop do
  move = dirs.min_by do |k, v|
    (end_point[0] + v[0]).abs + (end_point[1] + v[1]).abs
  end[1]

  end_point[0] += move[0]
  end_point[1] += move[1]
  steps_home += 1

  break if end_point.all?(&:zero?)
end

p steps_home
