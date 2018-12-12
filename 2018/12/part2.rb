#!/usr/bin/env ruby

require_relative "../challenge_utils"
include ChallengeUtils

## SOLUTION BEGINS

FPOT = "#"
EPOT = "."
def solve(input)
  offset = 1_000

  pots = [EPOT]*offset + input.shift.match(/([\.#]+)/)[1].chars + [EPOT]*offset
  input.shift # blank line
  generational_changes = input.inject({}) do |hsh, txn|
    from, to = txn.match(/([\.#]{5}) => ([\.#])/)[1..-1]
    hsh.merge(from => to)
  end

  new_pots = pots.dup
  last_score = score(pots, offset)
  last_diff  = 0
  500.times do |g|
    new_pots = [EPOT]*2 # these ones won't change
    new_pots += pots.each_cons(5).map { |pot_group| generational_changes[pot_group.join] || EPOT }
    new_pots += [EPOT]*2 # these ones won't change
    pots = new_pots

    new_score = score(pots, offset)
    puts "[#{g+1}] #{new_score} #{diff = (new_score - last_score)}"
    if diff == last_diff # this pattern will repeat
      return new_score + (50_000_000_000 - (g+1)) * last_diff
    end
    last_score = new_score
    last_diff  = diff
  end
end

def score(pots, offset)
  pots.map.with_index do |pot, i|
    pot == FPOT ? i-offset : 0
  end.reduce(&:+)
end
## SOLUTION ENDS

puts "-"*50, ""

# solve for reals
puts "Solution:", solve(read_input("input"))
