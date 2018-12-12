#!/usr/bin/env ruby

require_relative "../challenge_utils"
include ChallengeUtils

## SOLUTION BEGINS
def solve(input)
  offset = 50
  pots = ["."]*offset + input.shift.match(/([\.#]+)/)[1].chars + ["."]*offset
  input.shift # blank line
  generational_changes = input.inject({}) do |hsh, txn|
    from, to = txn.match(/([\.#]{5}) => ([\.#])/)[1..-1]
    hsh.merge(from => to)
  end

  new_pots = pots.dup
  20.times do |g|
    puts "[#{((g+1).to_s).rjust(2)}] #{new_pots.join}"
    new_pots = ["."]*2 # these ones won't change
    new_pots += pots.each_cons(5).map do |pot_group|
      generational_changes[pot_group.join] || "."
    end
    new_pots += ["."]*2 # these ones won't change
    pots = new_pots
  end

  pots.map.with_index do |pot, i|
    pot == "#" ? i-offset : 0
  end.reduce(&:+)
end
## SOLUTION ENDS

# test scenarios
test(%(initial state: #..#.#..##......###...###

...## => #
..#.. => #
.#... => #
.#.#. => #
.#.## => #
.##.. => #
.#### => #
#.#.# => #
#.### => #
##.#. => #
##.## => #
###.. => #
###.# => #
####. => #).split("\n"), 325)

puts "-"*50, ""

# solve for reals
puts "Solution:", solve(read_input("input"))
