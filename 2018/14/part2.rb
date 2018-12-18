#!/usr/bin/env ruby

require_relative "../challenge_utils"
include ChallengeUtils

## SOLUTION BEGINS
def solve(args)
  starting_recipes, recipe_scores = *args
  elves   = [0, 1]
  to_match = recipe_scores.chars.map(&:to_i)
  recipes  = starting_recipes.chars.map(&:to_i)

  n = matched_at = matched = 0
  loop do 
    new_score = elves.map { |e| recipes[e] }.reduce(&:+)
    new_score.to_s.chars.map(&:to_i).each do |s|
      matched = matched_at = 0 if s != to_match[matched]
      if s == to_match[matched]
        matched_at = recipes.size if matched == 0
        matched += 1
        return matched_at if matched == to_match.size
      end
      recipes << s
    end
    elves.map! do |elf|
      (elf + 1 + recipes[elf]) % recipes.size
    end

    # print_recipe_scores(recipe, elves)
    puts n if n > 1 && n % 100_000 == 0 
    n+=1
  end
end

def print_recipe_scores(scores, elves)
  scores.each.with_index do |s, i| 
    if i == elves[0]
      print "("
    elsif i == elves[1]
      print "["
    else 
      print " "
    end

    print s

    if i == elves[0]
      print ")"
    elsif i == elves[1]
      print "]"
    else 
      print " "
    end
  end
  puts
end
## SOLUTION ENDS

# test scenarios
test(["37", "51589"], 9)
test(["37", "01245"], 5)
test(["37", "92510"], 18)
test(["37", "59414"], 2018)

puts "-"*50, ""

# solve for reals
puts "Solution:", solve(["37", "640441"])
