require_relative "../puzzle"

class Day10P1 < Puzzle
  def test_cases
    { # {input => expected}
      ['16', '10', '15', '5', '1', '11', '7', '19', '6', '12', '4'] => 7 * 5,
      ['28', '33', '18', '42', '31', '14', '46', '20',
       '48', '47', '24', '23', '49', '45', '19', '38',
       '39', '11', '1', '32', '25', '35', '8', '17',
       '7', '9', '4', '2', '34', '10', '3'] => 22 * 10
    }
  end

  def solve(input, testing: false)
    adapter_joltages = input.map(&:to_i).sort
    device_jolt_rating = adapter_joltages.max + 3
    adapter_joltages << device_jolt_rating
    outlet_joltage = 0

    prev_jolts = outlet_joltage
    jolt_differences = adapter_joltages.each.with_object(Hash.new(0)) do |jolts, hsh|
      hsh[jolts - prev_jolts] += 1
      prev_jolts = jolts
    end

    jolt_differences[1] * jolt_differences[3]
  end
end
