require_relative "../puzzle"
class Day07P2 < Puzzle
  def test_cases
    { # {input => expected}
      [
        'faded blue bags contain 0 other bags.',
        'dotted black bags contain 0 other bags.',
        'vibrant plum bags contain 11 other bags: 5 faded blue bags and 6 dotted black bags.',
        'dark olive bags contain 7 other bags: 3 faded blue bags and 4 dotted black bags.'
      ] => 32,
      [
        'shiny gold bags contain 2 dark red bags.',
        'dark red bags contain 2 dark orange bags.',
        'dark orange bags contain 2 dark yellow bags.',
        'dark yellow bags contain 2 dark green bags.',
        'dark green bags contain 2 dark blue bags.',
        'dark blue bags contain 2 dark violet bags.',
        'dark violet bags contain no other bags.'
      ] => 126
    }
  end

  def solve(input, testing: false)
    @bag_relationships = build_bag_relationships(input)

    # find_all_possible_bags_containing_recursively('shiny gold bag')

    next_searching_for = ['shiny gold bag']
    possible_nestings  = 0
    outer_bags_seen = []
    loop do
      searching_for = next_searching_for.dup
      next_searching_for.clear

      next_searching_for = searching_for.map.with_object([]) do |bag, arr|
        bag_name, can_contain = find_bags_that_can_hold(bag)
        arr << find_bags_that_can_hold(bag)
      end.flatten.uniq

      # Only count new outer bags
      next_searching_for -= outer_bags_seen
      outer_bags_seen += next_searching_for

      possible_nestings += next_searching_for.size
      break if next_searching_for.empty?
    end

    possible_nestings
  end

  def build_bag_relationships(rule_list)
    rule_list.each.with_object({}) do |rule, relationships|
      bag_name    = rule.scan(/^([a-z ]+ bag)s contain/).flatten.first
      can_contain = rule.scan(/(\d+) ([a-z ]+ bag)/).map.with_object({}) do |(quantity, description), hsh|
        hsh[description] = quantity.to_i
      end
      relationships[bag_name] = can_contain
    end
  end

  def find_all_possible_bags_containing_recursively(bag)
    containing_bags = @bag_relationships.select do |bag_name, can_contain|
      bag_name if can_contain.keys.include?(bag)
    end.keys

    puts bag, containing_bags.inspect

    if containing_bags.empty?
      1
    else
      1 + containing_bags.map do |containing_bag|
        find_all_possible_bags_containing_recursively(containing_bag)
      end.reduce(&:+)
    end
  end

  def find_bags_that_can_hold(bag)
    @bag_relationships.select do |bag_name, can_contain|
      bag_name if can_contain.keys.include?(bag)
    end
  end
end
