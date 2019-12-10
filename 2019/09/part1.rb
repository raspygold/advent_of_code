require_relative "../puzzle"
class Day9P1 < Puzzle
  def test_cases
    { # {input => expected}
      "109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99" => 99,
      "1102,34915192,34915192,7,4,7,99,0" => 1219070632396864,
      "104,1125899906842624,99" => 1125899906842624
    }
  end

  def resolve(m, a, prog, r_idx)
    {
      0 => prog[a],
      1 => a,
      2 => prog[r_idx + a],
    }[m]
  end

  def solve(input, testing: false)
    program = input.split(',').map(&:to_i)
    program += ([0] * 1_000_000) # pad program memory heap
    prog_input  = [1]
    prog_output = []

    idx = r_idx = 0
    loop do
      opcode = program[idx]
      m = Array(opcode.digits[2..-1])
      m << 0 while m.size < 3 # pad it
      opcode = opcode % 100

      case opcode
      when 1 # Add
        a, b, c = program.slice(idx+1, 3)
        program[c] = resolve(m[0], a, program, r_idx) + resolve(m[1], b, program, r_idx)
        idx += 4
      when 2 # Multiply
        a, b, c = program.slice(idx+1, 3)
        program[c] = resolve(m[0], a, program, r_idx) * resolve(m[1], b, program, r_idx)
        idx += 4
      when 3 # Ingest input
        a = program.slice(idx+1)
        program[a] = prog_input.shift
        idx += 2
      when 4 # Output
        a = program.slice(idx+1)
        # puts "Outputing:"
        # puts [m[0], a, r_idx, resolve(m[0], a, program, r_idx)].inspect
        prog_output << resolve(m[0], a, program, r_idx)
        idx += 2
      when 5 # Jump-if-true
        a, b = program.slice(idx+1, 2)
        if resolve(m[0], a, program, r_idx) != 0
          idx = resolve(m[1], b, program, r_idx)
        else
          idx += 3
        end
      when 6 # Jump-if-false
        a, b = program.slice(idx+1, 2)
        if resolve(m[0], a, program, r_idx) == 0
          idx = resolve(m[1], b, program, r_idx)
        else
          idx += 3
        end
      when 7 # Less than
        a, b, c = program.slice(idx+1, 3)
        program[c] = resolve(m[0], a, program, r_idx) < resolve(m[1], b, program, r_idx) ? 1 : 0
        idx += 4
      when 8 # Equals
        a, b, c = program.slice(idx+1, 3)
        program[c] = resolve(m[0], a, program, r_idx) == resolve(m[1], b, program, r_idx) ? 1 : 0
        idx += 4
      when 9 # Adjust relative base
        a = program.slice(idx+1)
        r_idx += resolve(m[0], a, program, r_idx)
        idx += 2
      when 99
        break
      end
    end

    puts prog_output.inspect
    prog_output.last
  end
end
