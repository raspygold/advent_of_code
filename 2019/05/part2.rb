require_relative "../puzzle"
class Day5P2 < Puzzle

  def test_cases
    { # {input => expected}
      "3,9,8,9,10,9,4,9,99,-1,8" => 0,
      "3,9,7,9,10,9,4,9,99,-1,8" => 1,
      "3,3,1108,-1,8,3,4,3,99" => 0,
      "3,3,1107,-1,8,3,4,3,99" => 1,
      "3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9" => 1,
      "3,3,1105,-1,9,1101,0,0,12,4,12,99,1" => 1,
      "3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99" => 999
    }
  end

  def resolve(m, a, arr)
    m == 0 ? arr[a] : a
  end

  def solve(input, testing: false)
    arr = input.split(',').map(&:to_i)
    prog_input  = [5]
    prog_output = []

    idx = 0
    loop do
      opcode = arr[idx]
      m = Array(opcode.digits[2..-1])
      m << 0 while m.size < 3 # pad it
      opcode = opcode % 100

      case opcode
      when 1 # Add
        a, b, c = arr.slice(idx+1, 3)
        arr[c] = resolve(m[0], a, arr) + resolve(m[1], b, arr)
        idx += 4
      when 2 # Multiply
        a, b, c = arr.slice(idx+1, 3)
        arr[c] = resolve(m[0], a, arr) * resolve(m[1], b, arr)
        idx += 4
      when 3 # Ingest input
        a = arr.slice(idx+1)
        arr[a] = prog_input.shift
        idx += 2
      when 4 # Output
        a = arr.slice(idx+1)
        prog_output << resolve(m[0], a, arr)
        idx += 2
      when 5 # Jump-if-true
        a, b = arr.slice(idx+1, 2)
        if resolve(m[0], a, arr) != 0
          idx = resolve(m[1], b, arr)
        else
          idx += 3
        end
      when 6 # Jump-if-false
        a, b = arr.slice(idx+1, 2)
        if resolve(m[0], a, arr) == 0
          idx = resolve(m[1], b, arr)
        else
          idx += 3
        end
      when 7 # Less than
        a, b, c = arr.slice(idx+1, 3)
        arr[c] = resolve(m[0], a, arr) < resolve(m[1], b, arr) ? 1 : 0
        idx += 4
      when 8 # Equals
        a, b, c = arr.slice(idx+1, 3)
        arr[c] = resolve(m[0], a, arr) == resolve(m[1], b, arr) ? 1 : 0
        idx += 4
      when 99
        break
      end
    end

    prog_output.last
  end
end
