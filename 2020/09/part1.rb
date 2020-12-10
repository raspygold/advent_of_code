require_relative "../puzzle"

class Day09P1 < Puzzle
  def test_cases
    { # {input => expected}
      ['35','20','15','25','47','40',
       '62','55','65','95','102','117',
       '150','182','127','219','299',
       '277','309','576'] => 62
    }
  end

  def solve(input, testing: false)
    preamble_length = testing ? 5 : 25

    numbers = input.map(&:to_i)
    invalid_idx = (preamble_length..numbers.size).to_a.find do |idx|
      numbers[idx] unless numbers[(idx - preamble_length)...idx].permutation(2).any? do |a, b|
        (a + b) == numbers[idx]
      end
    end

    numbers[invalid_idx]
  end
end
