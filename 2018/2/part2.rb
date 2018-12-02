#!/usr/bin/env ruby

require_relative "../challenge_utils"
include ChallengeUtils

## SOLUTION BEGINS
def solve(input)
  id1 = id2 = nil
  diff = 0
  common_chars = []

  loop do
    id1 = input.shift
    input.each do |id2|
      diff = 0
      common_chars = []

      id1_chars, id2_chars = [id1, id2].map(&:chars)
      id1_chars.each.with_index do |id1c, i|
        if id1c == id2_chars[i] 
          common_chars << id1c
        else
          diff += 1 
        end
        break if diff > 1
      end
      break if diff == 1
    end
    break if input.empty? || diff == 1
  end

  common_chars.join
end
## SOLUTION ENDS

# test scenarios
test(%Q(abcde
fghij
klmno
pqrst
fguij
axcye
wvxyz).split("\n"), "fgij")

puts "-"*50, ""

# solve for reals
puts "Solution:", solve(read_input("input"))
