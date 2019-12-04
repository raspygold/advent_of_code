require_relative "../puzzle"
class Day1Part1 < Puzzle
  def test_cases
    { # {input => expected}
      [12]     => 2,
      [14]     => 2,
      [1969]   => 654,
      [100756] => 33583,
    }
  end

  def solve(input, testing: false)
    fuel = input.map(&:to_i).map do |mass|
      (mass / 3.0).floor - 2
    end

    fuel.sum
  end
end
