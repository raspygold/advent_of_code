require_relative "../puzzle"
class Day6P1 < Puzzle
  def test_cases
    { # {input => expected}
      ["COM)B", "B)C", "C)D", "D)E", "E)F", "B)G", "G)H", "D)I", "E)J", "J)K", "K)L"] => 42
    }
  end

  def solve(input, testing: false)
    orbit_rules = input.map { |x| x.split(")") }
    orbit_count = 0
    last_gen = orbit_rules.map(&:first) - orbit_rules.map(&:last)
    gen_count = 1
    loop do
      this_gen = orbit_rules.select { |a, _| last_gen.include?(a) }
      this_gen.each do |a, b|
        orbit_count += gen_count
      end
      break if this_gen.map(&:last).empty?
      last_gen = this_gen.map(&:last)
      gen_count += 1
    end

    orbit_count
  end
end
