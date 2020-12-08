require_relative "../puzzle"
class Day07P2 < Puzzle
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

    number_of_bags_contained_in('shiny gold bag') - 1 # don't count the outer bag
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

  def number_of_bags_contained_in(bag)
    bags_inside = (@bag_relationships[bag].map do |bag_description, quantity|
      number_of_bags_contained_in(bag_description) * quantity
    end.reduce(&:+)) || 0
    1 + bags_inside
  end

  def find_bags_that_can_hold(bag)
    @bag_relationships.select do |bag_name, can_contain|
      bag_name if can_contain.keys.include?(bag)
    end
  end
end
