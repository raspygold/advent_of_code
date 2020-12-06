require_relative "../puzzle"
class Day01P1 < Puzzle
  def test_cases
    { # {input => expected}
     ['1721', '979', '366', '299', '675', '1456'] => 514_579
    }
  end

  def solve(input, testing: false)
    input.map(&:to_i).permutation(2).find do |f1, f2|
      f1 + f2 == 2_020
    end.reduce(&:*)
  end
end
