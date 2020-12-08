require_relative "../puzzle"
class Day07P1 < Puzzle
  def test_cases
    { # {input => expected}
      [
        'light red bags contain 1 bright white bag, 2 muted yellow bags.',
        'dark orange bags contain 3 bright white bags, 4 muted yellow bags.',
        'bright white bags contain 1 shiny gold bag.',
        'muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.',
        'shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.',
        'dark olive bags contain 3 faded blue bags, 4 dotted black bags.',
        'vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.',
        'faded blue bags contain no other bags.',
        'dotted black bags contain no other bags.'
      ] => 4
    }
  end

  def solve(input, testing: false)
    @bag_relationships = build_bag_relationships(input)

    next_searching_for = ['shiny gold bag']
    possible_nestings  = 0
    outer_bags_seen = []
    loop do
      searching_for = next_searching_for.dup
      next_searching_for.clear

      next_searching_for = searching_for.map.with_object([]) do |bag, arr|
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

  def find_bags_that_can_hold(bag)
    @bag_relationships.select do |bag_name, can_contain|
      bag_name if can_contain.keys.include?(bag)
    end.keys
  end
end
