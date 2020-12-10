require_relative "../puzzle"

class Day10P2 < Puzzle
  def test_cases
    { # {input => expected}
      ['16', '10', '15', '5', '1', '11', '7', '19', '6', '12', '4'] => 8,
      ['28', '33', '18', '42', '31', '14', '46', '20',
       '48', '47', '24', '23', '49', '45', '19', '38',
       '39', '11', '1', '32', '25', '35', '8', '17',
       '7', '9', '4', '2', '34', '10', '3'] => 19_208
    }
  end

  def solve(input, testing: false)
    adapter_joltages   = input.map(&:to_i).sort
    device_jolt_rating = adapter_joltages.max + 3
    outlet_joltage = 0
    adapter_joltages.unshift(outlet_joltage)
    adapter_joltages << device_jolt_rating

    opts = Hash.new(0)
    opts[outlet_joltage] = 1
    adapter_joltages.each do |joltage|
      opts[joltage] += opts[joltage - 1] + opts[joltage - 2] + opts[joltage - 3]
    end

    opts[adapter_joltages.max]
  end
end
