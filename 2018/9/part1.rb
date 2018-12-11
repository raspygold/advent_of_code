#!/usr/bin/env ruby

require_relative "../challenge_utils"
include ChallengeUtils

## SOLUTION BEGINS
def solve(input)
  players, last_marble_value = input.match(/(\d+) players; last marble is worth (\d+) points/)[1..-1].map(&:to_i)
  elf_scores = (0...players).map {[0]}
  # elf_scores = [[]] * players

  marble_circle      = []
  current_marble_idx = 0
  remaining_marbles  = (0..last_marble_value).to_a
  marble_circle << remaining_marbles.shift # initial state

  elf_scores.cycle do |score|
    next_marble = remaining_marbles.shift
    if next_marble % 23 == 0
      score << next_marble
      current_marble_idx = (current_marble_idx - 7) % marble_circle.size
      score << marble_circle.delete_at(current_marble_idx)
    else
      insert_idx = (current_marble_idx + 2) % marble_circle.size
      marble_circle.insert(insert_idx, next_marble)
      current_marble_idx = insert_idx
    end

    break if remaining_marbles.empty?
  end

  elf_scores.map {|score| score.reduce(&:+)}.max
end
## SOLUTION ENDS

# test scenarios
test("9 players; last marble is worth 25 points", 32)
test("10 players; last marble is worth 1618 points", 8317)
test("13 players; last marble is worth 7999 points", 146373)
test("17 players; last marble is worth 1104 points", 2764)
test("21 players; last marble is worth 6111 points", 54718)
test("30 players; last marble is worth 5807 points", 37305)

puts "-"*50, ""

# solve for reals
puts "Solution:", solve(read_input("input"))
