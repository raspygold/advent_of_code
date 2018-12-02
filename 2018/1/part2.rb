#!/usr/bin/env ruby

require_relative "../challenge_utils"
include ChallengeUtils

## SOLUTION BEGINS
def solve(input)
  require "set"
  seen_frequencies = Set.new()
  frequency = 0

  loop do 
    break if seen_frequencies.include?(frequency)
    
    seen_frequencies << frequency
    frequency += input.first.to_i
    input.rotate!
  end

  frequency
end
## SOLUTION ENDS

# test scenarios
test(["+1", "-1"], 0)
test(["+3", "+3", "+4", "-2", "-4"], 10)
test(["-6", "+3", "+8", "+5", "-6"], 5)
test(["+7", "+7", "-2", "-7", "-4"], 14)

puts "-"*50, ""

# solve for reals
puts "Solution:", solve(read_input("input"))
