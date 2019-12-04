require_relative "../puzzle"
class Day4Part2 < Puzzle
  def test_cases
    { # {input => expected}
      "112233-112233" => 1,
      "123444-123444" => 0,
      "111122-111122" => 1,
    }
  end

  def solve(input, testing: false)
    count = 0
    min, max = input.split('-').map(&:to_i)
    (min..max).each do |n|
      next unless n.between?(100_000, 999_999)
      da = n.digits.reverse
      next if da != da.sort
      next unless da.group_by { |x| x }.any? { |k, v| v.size == 2 }

      count += 1
    end
    count
  end
end
