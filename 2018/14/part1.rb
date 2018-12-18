#!/usr/bin/env ruby

require_relative "../challenge_utils"
include ChallengeUtils

## SOLUTION BEGINS
Elf = Struct.new(:current_recipe_idx)
def solve(args)
  input, after_recipes, num_scores = *args
  elves  = [Elf.new(0), Elf.new(1)]
  recipe = input.chars.map(&:to_i)

  # print_recipe_scores(recipe.last, elves)

  n = 0
  loop do 
    new_score = elves.map { |e| recipe[e.current_recipe_idx] }.reduce(&:+)
    recipe += new_score.to_s.chars.map(&:to_i)
    elves.each.with_index do |elf, i|
      elf.current_recipe_idx = (elf.current_recipe_idx + 1 + recipe[elf.current_recipe_idx]) % recipe.size
    end

    # print_recipe_scores(recipe, elves)
    puts n if n % 1_000 == 0

    if recipe.size > (after_recipes + num_scores)
      puts
      return recipe[after_recipes, num_scores].join
    end 
    n+=1
  end
end

def print_recipe_scores(scores, elves)
  scores.each.with_index do |s, i| 
    if i == elves[0].current_recipe_idx
      print "("
    elsif i == elves[1].current_recipe_idx
      print "["
    else 
      print " "
    end

    print s

    if i == elves[0].current_recipe_idx
      print ")"
    elsif i == elves[1].current_recipe_idx
      print "]"
    else 
      print " "
    end
  end
  puts
end
## SOLUTION ENDS

# test scenarios
test(["37",    9, 10], "5158916779")
test(["37",    5, 10], "0124515891")
test(["37",   18, 10], "9251071085")
test(["37", 2018, 10], "5941429882")

puts "-"*50, ""

# solve for reals
puts "Solution:", solve(["37", 640_441, 10])
