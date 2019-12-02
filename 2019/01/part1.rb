#!/usr/bin/env ruby
require_relative "../utils"
include Utils

## SOLUTION BEGINS
def solve(input)
  fuel = input.map do |mass|
    (mass / 3.0).floor - 2
  end

  fuel.sum
end
## SOLUTION ENDS

# test scenarios
test([12], 2)
test([14], 2)
test([1969], 654)
test([100756], 33583)

puts "-"*50, ""

# solve for reals
puts "Solution:", solve(read_input(ints: true ))
