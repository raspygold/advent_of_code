require_relative "../puzzle"
class Day4Part1 < Puzzle
  def test_cases
    { # {input => expected}
      "111111-111111" => 1,
      "223450-223450" => 0,
      "123789-123789" => 0,
    }
  end

  def solve(input, testing: false)
    count = 0
    min, max = input.split('-').map(&:to_i)
    (min..max).each do |n|
      next unless n.between?(100_000, 999_999)
      da = n.digits.reverse
      next if da != da.sort
      next unless da.group_by { |x| x }.any? { |k, v| v.size > 1 }

      count += 1
    end
    count
  end
end
