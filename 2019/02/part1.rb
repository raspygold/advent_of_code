require_relative "../puzzle"
class Day2Part1 < Puzzle
  def test_cases
    { # {input => expected}
      "1,9,10,3,2,3,11,0,99,30,40,50" => 3500,
    }
  end

  def solve(input, testing: false)
    arr = input.split(',').map(&:to_i)
    puts arr.inspect
    unless testing
      arr[1] = 12
      arr[2] = 2
    end

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
      else
        raise "oops"
      end

      break if arr.empty?
    end

    arr[0]
  end
end