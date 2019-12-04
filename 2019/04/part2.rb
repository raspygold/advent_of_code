require_relative "../puzzle"
class Day3Part1 < Puzzle
  def test_cases
    { # {input => expected}
      "112233-112233" => 1,
      "123444-123444" => 0,
      "111122-111122" => 1,
    }
  end

  # Use `testing` when the test cases behaviour differs
  def solve(input, testing: false)
    count = 0
    min, max = input.split('-').map(&:to_i)
    (min..max).each do |n|
      next if n < 100_000 || n > 999_999
      da = n.digits.reverse
      next if da != da.sort
      next unless da.group_by { |x|x }.any? {|k,v| v.size == 2 }

      count += 1
    end
    count
  end
end
