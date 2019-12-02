#!/usr/bin/env ruby
require_relative "../utils"
include Utils

## SOLUTION BEGINS
def solve(input)
  fuel_calc = -> (mass) { (mass / 3.0).floor - 2 }
  total_fuel = 0
  next_cycle = input

  loop do
    cycle = next_cycle

    fuel = cycle.map do |mass|
      [0, fuel_calc.(mass)].max
    end

    fuel.reject!(&:zero?)
    total_fuel += fuel.sum
    next_cycle = fuel
    break if next_cycle.empty?
  end

  total_fuel
end
## SOLUTION ENDS

# test scenarios
test([12], 2)
test([14], 2)
test([1969], 966)
test([100756], 50346)

puts "-"*50, ""

# solve for reals
puts "Solution:", solve(read_input(ints: true ))
