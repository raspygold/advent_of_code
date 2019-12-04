require_relative "../puzzle"
class Day2Part2 < Puzzle
  def test_cases
    { # {input => expected}
    }
  end

  def solve(input, testing: false)
    orig = input.split(',').map(&:to_i).freeze

    noun = 0
    verb = 0
    desired = 19690720

    100.times do |noun|
      100.times do |verb|
        arr = orig.dup
        arr[1] = noun
        arr[2] = verb
        idx = 0
        loop do
          opcode = arr[idx]
          case opcode
          when 1
            i1, i2, i3 = arr.slice(idx+1, 3)
            arr[i3] = arr[i1] + arr[i2]
            idx += 4
          when 2
            i1, i2, i3 = arr.slice(idx+1, 3)
            arr[i3] = arr[i1] * arr[i2]
            idx += 4
          when 99
            break
          end

          return 100 * noun + verb if arr[0] == 19690720
        end
      end
    end
  end
end