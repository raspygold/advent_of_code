require_relative "../puzzle"
class Day6P1 < Puzzle
  def test_cases
    { # {input => expected}
    }
  end

  def build_path_to(target)
    reverse_path = [target]
    loop do
      break if reverse_path.last == $root
      reverse_path << $orbits.find { |a, b| b.include?(reverse_path.last) }[0]
    end

    reverse_path
  end

  def solve(input, testing: false)
    orbit_rules = input.map { |x| x.split(")") }
    $root = (orbit_rules.map(&:first) - orbit_rules.map(&:last)).first
    $orbits = Hash.new { |h, k| h[k] = [] }
    orbit_rules.each do |k, v|
      $orbits[k] << v
    end

    you_path = build_path_to("YOU")
    san_path = build_path_to("SAN")

    cross = (you_path & san_path).first
    you_path.index(cross) + san_path.index(cross) - 2
  end
end
