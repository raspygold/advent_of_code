#!/usr/bin/env ruby
$input = 1358

def open_space?(x,y)
  (x*x + 3*x + 2*x*y + y + y*y + $input).to_s(2).split("").select { |i| i == "1" }.size.even?
end

def print_floor
  puts

  plan = $floor_plan.transpose
  print "  "
  plan.size.times { |x| print (x = (x / 10).floor) > 0 ? x : " " }
  puts
  print "  "
  plan.size.times { |x| print x % 10 }
  puts

  plan.each.with_index do |row, y|
    print y.to_s.rjust(2)
    row.each.with_index do |c, x|
      if c == 1
        print $visited_positions.include?([x,y]) ? "O" : " "
      else
        print "█"
      end
    end
    puts
  end
end

def determine_next_moves(current_positions)
  next_positions = Set.new
  current_positions.each do |x, y|
    possible_positions = [-1, 1].map { |n| [x + n, y] } +
                         [-1, 1].map { |n| [x, y + n] }

    possible_positions.each do |new_x, new_y|
      new_position = [new_x, new_y]
      if new_position.all? { |c| c.between?(0, $floor_plan.size - 1) } && !$visited_positions.include?(new_position) && $floor_plan[new_x][new_y] == 1
        next_positions << new_position
        $visited_positions << new_position
      end
    end
  end

  next_positions
end

require "set"
$visited_positions = Set.new()

map_size = 50
$floor_plan = map_size.times.map { |x| map_size.times.map { |y| open_space?(x, y) ? 1 : 0 } } # space => 1, wall => 0
print_floor

next_positions = Set.new([[1,1]])
$visited_positions << [1,1]
i = 1
loop do
  next_positions = determine_next_moves(next_positions)

  print "."
  break if i >= 50
  i += 1
end

print_floor

puts "", "The numbe of locations (distinct x,y coordinates, including your starting location) that can be reached in at most 50 steps is: #{$visited_positions.size}"
