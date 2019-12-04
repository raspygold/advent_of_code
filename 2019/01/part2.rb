require_relative "../puzzle"
class Day1Part2 < Puzzle
  def test_cases
    { # {input => expected}
      [12]     => 2,
      [14]     => 2,
      [1969]   => 966,
      [100756] => 50346,
    }
  end

  def solve(input, testing: false)
    fuel_calc = -> (mass) { (mass / 3.0).floor - 2 }
    total_fuel = 0
    next_cycle = input.map(&:to_i)

    loop do
      cycle = next_cycle

      fuel = cycle.map do |mass|
        [0, fuel_calc.(mass)].max
      end

      fuel.reject!(&:zero?)
      total_fuel += fuel.sum
      next_cycle = fuel
      break if next_cycle.empty?
    end

    total_fuel
  end
end