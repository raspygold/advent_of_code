require_relative "../puzzle"

class Day09P2 < Puzzle
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
    invalid_number = numbers[invalid_idx]

    numbers.size.times do |idx|
      num_group = [numbers[idx]]
      next_idx = idx
      loop do
        next_idx += 1

        break if next_idx >= numbers.size || num_group.reduce(&:+) >= invalid_number

        num_group << numbers[next_idx]
      end

      return num_group.sort.values_at(0, -1).reduce(&:+) if num_group.reduce(&:+) == invalid_number
    end
  end
end
