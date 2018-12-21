#!/usr/bin/env ruby

require_relative "../challenge_utils"
include ChallengeUtils

## SOLUTION BEGINS
ROOM="."
WALL="#"
VDOOR="|"
HDOOR="-"
CURPOS="X"
UNSURE="?"

DIRS = {
  "N" => [ 0,-1],
  "E" => [ 1, 0],
  "S" => [ 0, 1],
  "W" => [-1, 0]
}
DOOR_DIRS = {
  "N" => HDOOR,
  "E" => VDOOR,
  "S" => HDOOR,
  "W" => VDOOR,
}
MAP_YSIZE = 215
MAP_XSIZE = 235
def solve(input)
  movements = input.chars[1...-1]
  $map = Array.new(MAP_YSIZE) { Array.new(MAP_XSIZE) } # odd so that there's a clear center cell

  origin = [MAP_XSIZE / 2, MAP_YSIZE / 2]
  $map[origin[1]][origin[0]] = ROOM
  
  pos = origin.dup
  create_map(movements, pos)
  fill_map
  print_map(origin)

  $rooms_to_find = []
  MAP_YSIZE.times do |y| 
    MAP_XSIZE.times do |x|
      $rooms_to_find << [x,y] if $map[y][x] == ROOM
    end
  end
  $rooms_to_find.delete(origin) # Don't want to find the origin

  $shortest_paths_to_rooms = {}
  search_for_rooms(origin)

  $shortest_paths_to_rooms.values.each {|path| path.delete(origin)}
  $shortest_paths_to_rooms = $shortest_paths_to_rooms.sort_by {|k, v| -v.size}.to_h

  $shortest_paths_to_rooms.values.first.size
end

def create_map(movements, pos)
  new_pos = pos.dup
  return if movements.empty?

  m = movements.shift

  # just need to handle stuff in brackets
  bracketed_movements = [[]]
  if m == "("
    brackets_seen = 1
    loop do 
      break if brackets_seen == 0
      mv = movements.shift
      if mv == "("
        brackets_seen += 1
        bracketed_movements.last << mv
      elsif mv == ")"
        brackets_seen -= 1
        bracketed_movements.last << mv unless brackets_seen == 0
      elsif mv == "|"
        if brackets_seen == 1
          bracketed_movements << []
        else 
          bracketed_movements.last << mv
        end
      else
        bracketed_movements.last << mv
      end
    end
  
  else # Do the normal movement
    # print_map(new_pos)
    dx = DIRS[m]
    # puts "#{m} #{dx.inspect}, #{new_pos}"
    new_pos[0] += dx[0]
    new_pos[1] += dx[1]

    $map[new_pos[1]][new_pos[0]] = DOOR_DIRS[m]
    if DOOR_DIRS[m] == HDOOR
      $map[new_pos[1]][new_pos[0]-1] = $map[new_pos[1]][new_pos[0]+1] = WALL
    else
      $map[new_pos[1]-1][new_pos[0]] = $map[new_pos[1]+1][new_pos[0]] = WALL
    end

    new_pos[0] += dx[0]
    new_pos[1] += dx[1]
    $map[new_pos[1]][new_pos[0]] = ROOM
  end

  if bracketed_movements.flatten.any?
    bracketed_movements.each do |bracketed_movements|
      create_map(bracketed_movements, new_pos)
    end
  end

  create_map(movements, new_pos)
end

def print_map(pos)
  MAP_YSIZE.times do |y| 
    MAP_XSIZE.times do |x|
      print pos == [x,y] ? CURPOS : $map[y][x] || " "
    end
    puts
  end
  puts
  puts
end

def fill_map
  MAP_YSIZE.times do |y| 
    MAP_XSIZE.times do |x|
      $map[y][x] ||= WALL
    end
  end
end

def search_for_rooms(origin)
  steps = 0
  paths = [{ movements: [], position: origin }]
  loop do 
    break if $rooms_to_find.empty?
    # print "."

    new_paths = []
    paths.each do |path|
      DIRS.each do |d, dx|
        new_pos = [path[:position][0] + dx[0], path[:position][1] + dx[1]]
        if [HDOOR, VDOOR].include?($map[new_pos[1]][new_pos[0]]) # if walking through a door
          new_pos = [new_pos[0] + dx[0], new_pos[1] + dx[1]]
          unless path[:movements].include?(new_pos) || !$rooms_to_find.include?(new_pos)
            new_movements = path[:movements] + [new_pos]
            $shortest_paths_to_rooms[new_pos] = new_movements
            new_paths << { movements: new_movements, position: new_pos }
            $rooms_to_find.delete(new_pos)
          end
        end
      end
    end
    steps += 1
    paths = new_paths
  end
end

# test scenarios
test("^WNE$", 3)
test("^ENWWW(NEEE|SSE(EE|N))$", 10)
test("^ENNWSWW(NEWS|)SSSEEN(WNSE|)EE(SWEN|)NNN$", 18)
test("^ESSWWN(E|NNENN(EESS(WNSE|)SSS|WWWSSSSE(SW|NNNE)))$", 23)
test("^WSSEESWWWNW(S|NENNEEEENN(ESSSSW(NWSW|SSEN)|WSWWN(E|WWS(E|SS))))$", 31)

puts "-"*50, ""

# solve for reals
puts "Solution:", solve(read_input("input"))
