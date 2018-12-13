#!/usr/bin/env ruby

require_relative "../challenge_utils"
include ChallengeUtils

## SOLUTION BEGINS
def solve(input)
  carts = []
  track = input.map.with_index do |row, y|
    row.chars.map.with_index do |cell, x|
      case cell
      when /[><\^v]/
        carts << { id: carts.size, position: [x,y], direction: cell, intersection_turns: ["l","s","r"] }
        [">","<"].include?(cell) ? "-" : "|" # complete the track as it the carts aren't there
      else
        cell
      end
    end
  end

  tick = 0
  past_cart_states = []
  loop do 
    past_cart_states << carts.map(&:dup)
    carts.sort_by! {|cart| cart[:position].reverse} # order carts
    carts.each.with_index do |cart, n|
      move_cart(cart, track)
      collisions = carts.group_by {|cart| cart[:position] }.select { |k,v| v.size > 1 }
      carts -= collisions.values.flatten
    end

    tick+=1
    if carts.size == 1
      return carts.first[:position].join(",") 
    end
  end
end

def draw_track(track, carts)
  track.size.times do |y|
    track[y].size.times do |x|
      if (here = carts.select {|cart| cart[:position] == [x,y]}.first)
        print "\e[1m#{here[:direction]}\e[22m"
      else
        print track[y][x]
      end
    end
    puts
  end
end

def move_cart(cart, track)
  cart[:position] = case cart[:direction]
  when ">"
    [cart[:position][0] + 1, cart[:position][1]]
  when "<"
    [cart[:position][0] - 1, cart[:position][1]]
  when "^"
    [cart[:position][0], cart[:position][1] - 1]
  when "v"
    [cart[:position][0], cart[:position][1] + 1]
  end
  change_direction(cart, track)
end

def change_direction(cart, track)
  cart[:direction] = case track[cart[:position][1]][cart[:position][0]]
  when "/"
    case cart[:direction]
    when ">"
      "^"
    when "v"
      "<"
    when "<"
      "v"
    when "^"
      ">"
    end
  when "\\"
    case cart[:direction]
    when "<"
      "^"
    when "v"
      ">"
    when ">"
      "v"
    when "^"
      "<"
    end
  when "+"
    turn_dir = cart[:intersection_turns].first
    cart[:intersection_turns].rotate!
    if turn_dir == "s" # go straight, do nothing
      cart[:direction] 
    else 
      case cart[:direction]
      when ">"
        turn_dir == "l" ? "^" : "v" 
      when "<"
        turn_dir == "l" ? "v" : "^"
      when "^"
        turn_dir == "l" ? "<" : ">"
      when "v"
        turn_dir == "l" ? ">" : "<"
      end
    end
  else
    cart[:direction]
  end
end
## SOLUTION ENDS

# test scenarios
test(%Q(/>-<\\  
|   |  
| /<+-\\
| | | v
\\>+</ |
  |   ^
  \\<->/
).split("\n"), "6,4")

puts "-"*50, ""

# solve for reals
puts "Solution:", solve(read_input("input", false))
