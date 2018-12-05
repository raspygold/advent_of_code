#!/usr/bin/env ruby

require_relative "../challenge_utils"
include ChallengeUtils

## SOLUTION BEGINS
def solve(input)
  reacted = false
  lowcase = ("a".."z").to_a
  matched_polarities = lowcase.zip(lowcase.map(&:upcase)).map(&:join)
  things_that_react = /#{(matched_polarities + matched_polarities.map(&:reverse)).join("|")}/
  matched_polarities.map do |unit_type|
    cleaned_input = input.gsub(/[#{unit_type}]/,"")
    loop do
      orig = cleaned_input.dup.freeze
      cleaned_input.gsub!(things_that_react, "")
      (orig != cleaned_input) ? print(".") : break
    end
    cleaned_input.size
  end.min
end
## SOLUTION ENDS

# test scenarios
test("dabAcCaCBAcCcaDA", 4)

puts "-"*50, ""

# solve for reals
puts "Solution:", solve(read_input("input"))
