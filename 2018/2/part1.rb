#!/usr/bin/env ruby

require_relative "../challenge_utils"
include ChallengeUtils

## SOLUTION BEGINS
def solve(input)
  duplicate_counts = Hash.new(0)
  input.map do |id|
    id.chars.sort_by(&:ord).group_by {|c| c}.values.map(&:size).uniq.select {|l| l.between?(2,3)}.each do |l|
      duplicate_counts[l] += 1
    end
  end
  duplicate_counts.values.reduce(&:*)
end
## SOLUTION ENDS

# test scenarios
test(["abcdef", "bababc", "abbcde", "abcccd", "aabcdd", "abcdee", "ababab"], 12)

puts "-"*50, ""

# solve for reals
puts "Solution:", solve(read_input("input"))
