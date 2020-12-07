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
    find_bags_to_hold('shiny gold bag', 0)
  end

  def find_bags_to_hold(description, count)
    next_step = input.select do |rule|
      rule.include?(description)
    end

    return count += 1

    next_step.map do |rule|
      rule.scan(/\d ([a-z ]+ bag)/).flat_map do |bag_desc|
        count += 1
      end
    end
  end
end
