#!/usr/bin/env ruby

require_relative "../challenge_utils"
include ChallengeUtils

## SOLUTION BEGINS
Marble = Struct.new(:value, :prev_m, :next_m)

def solve(input)
  players, last_marble_value = input.match(/(\d+) players; last marble is worth (\d+) points/)[1..-1].map(&:to_i)
  last_marble_value *= 100
  elf_scores = Hash.new(0)

  # initial state
  first_marble   = Marble.new(0)
  second_marble  = Marble.new(1)
  third_marble   = Marble.new(2)
  first_marble.prev_m  = second_marble
  first_marble.next_m  = third_marble
  second_marble.prev_m = third_marble
  second_marble.next_m = first_marble
  third_marble.prev_m  = first_marble
  third_marble.next_m  = second_marble
  
  current_marble = third_marble
  next_marble = 3
  (1..players).cycle.with_index do |elf, i| # order doesn't matter, as long as it is consistent
    elf_scores[elf]
    
    if next_marble % 23 == 0
      elf_scores[elf] += next_marble
      7.times { current_marble = current_marble.prev_m }
      to_delete = current_marble
      to_delete.prev_m.next_m = to_delete.next_m
      to_delete.next_m.prev_m = to_delete.prev_m
      current_marble = to_delete.next_m
      elf_scores[elf] += to_delete.value
    else
      current_marble = current_marble.next_m
      m = Marble.new(next_marble, current_marble, current_marble.next_m)
      current_marble.next_m.prev_m = m
      current_marble.next_m = m
      current_marble = m
    end
    next_marble+=1

    print "." if i % 10_000 == 0
    break if next_marble > last_marble_value
  end
  puts

  elf_scores.max_by {|k,v| v}[1]
end
## SOLUTION ENDS

puts "-"*50, ""

# solve for reals
puts "Solution:", solve(read_input("input"))
