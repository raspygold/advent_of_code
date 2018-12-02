#!/usr/bin/env ruby

require_relative "../challenge_utils"
include ChallengeUtils

## SOLUTION BEGINS
def solve(input)
  frequency = 0

  loop do 
    frequency += input.shift.to_i
    break if input.empty?
  end

  frequency
end
## SOLUTION ENDS

# test scenarios
test(["+1", "-2", "+3", "+1"], 3)
test(["+1", "+1", "+1"], 3)
test(["+1", "+1", "-2"], 0)
test(["-1", "-2", "-3"], -6)

puts "-"*50, ""

# solve for reals
puts "Solution:", solve(read_input("input"))
