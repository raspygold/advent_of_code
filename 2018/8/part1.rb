#!/usr/bin/env ruby

require_relative "../challenge_utils"
include ChallengeUtils

## SOLUTION BEGINS
def solve(input)
  nodes = []
  numbers = input.split(" ").map(&:to_i)
  identify_nodes(numbers, nodes)

  nodes.flatten.reduce(&:+)
end

def identify_nodes(numbers, nodes)
  children, metadata = numbers.shift(2)
  children.times { identify_nodes(numbers, nodes) }
  nodes << numbers.shift(metadata)
end
## SOLUTION ENDS

# test scenarios
test("2 3 0 3 10 11 12 1 1 0 1 99 2 1 1 2", 138)

puts "-"*50, ""

# solve for reals
puts "Solution:", solve(read_input("input"))
