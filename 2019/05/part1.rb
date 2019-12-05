require_relative "../puzzle"
class Day5P1 < Puzzle

  def test_cases
    { # {input => expected}
    }
  end

  def solve(input, testing: false)
    arr = input.split(',').map(&:to_i)
    w_idx = []
    prog_input  = [1]
    prog_output = []

    resolve = -> (m = 0, a, arr, w_idx) do
      if m == 0 || w_idx.include?(a)
         arr[a]
      else
        a
      end
    end

    idx = 0
    loop do
      opcode = arr[idx]
      digits = opcode.digits
      if digits.size > 2 # determine mode
        m = digits[2..-1]
        m << 0 while m.size < 3 # pad it
        opcode = digits.first
      else
        m = Array.new(3) {0}
      end

      case opcode
      when 1
        i1, i2, i3 = arr.slice(idx+1, 3)
        arr[i3] = resolve.(m[0], i1, arr, w_idx) + resolve.(m[1], i2, arr, w_idx)
        w_idx << i3
        idx += 4
      when 2
        i1, i2, i3 = arr.slice(idx+1, 3)
        arr[i3] = resolve.(m[0], i1, arr, w_idx) * resolve.(m[1], i2, arr, w_idx)
        w_idx << i3
        idx += 4
      when 3
        i1 = arr.slice(idx+1)
        arr[i1] = prog_input.shift
        w_idx << i1
        idx += 2
      when 4
        i1 = arr.slice(idx+1)
        prog_output << resolve.(m[0], i1, arr, w_idx)
        idx += 2
      when 99
        break
      end
    end

    puts prog_output.inspect
    prog_output.last
  end
end
