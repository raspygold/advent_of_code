#!/usr/bin/env ruby

require_relative "../challenge_utils"
include ChallengeUtils

## SOLUTION BEGINS
def solve(input)
  reacted = false
  lowcase = ("a".."z").to_a
  matched_polarities = lowcase.zip(lowcase.map(&:upcase)).map(&:join)
  matched_polarities += matched_polarities.map(&:reverse)
  things_that_react = /#{matched_polarities.join("|")}/
  loop do
    orig = input.dup.freeze
    input.gsub!(things_that_react, "")
    reacted = orig != input
    break unless reacted
  end
  input.size
end
## SOLUTION ENDS

# test scenarios
test("dabAcCaCBAcCcaDA", 10)

puts "-"*50, ""

# solve for reals
puts "Solution:", solve(read_input("input"))
