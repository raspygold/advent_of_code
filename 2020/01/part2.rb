require_relative "../puzzle"
class Day01P2 < Puzzle
  def test_cases
    { # {input => expected}
     ['1721', '979', '366', '299', '675', '1456'] => 241_861_950
    }
  end

  def solve(input, testing: false)
    input.map(&:to_i).permutation(3).find do |f1, f2, f3|
      f1 + f2 + f3 == 2_020
    end.reduce(&:*)
  end
end
