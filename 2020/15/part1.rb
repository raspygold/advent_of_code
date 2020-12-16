require_relative "../puzzle"

class Day15P1 < Puzzle

  def test_cases
    { # {input => expected}
      '0,3,6' => 436,
      '1,3,2' => 1,
      '2,1,3' => 10,
      '1,2,3' => 27,
      '2,3,1' => 78,
      '3,2,1' => 438,
      '3,1,2' => 1836,
    }
  end

  def solve(input, testing: false)
    nums = input.split(',').map(&:to_i)

    (nums.size...2020).each do |i|
      n = nums.last
      n_idxs = []
      nums.each.with_index do |v, j|
        n_idxs << j if v == n
      end
      age = if n_idxs.size < 2
        0
      else
        i - 1 - n_idxs[-2]
      end
      nums << age
    end

    nums[-1]
  end
end
