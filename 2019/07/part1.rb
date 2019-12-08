require_relative "../puzzle"
class Day7P1 < Puzzle
  def test_cases
    { # {input => expected}
    }
  end

  def solve(input, testing: false)
    program = input.split(',').map(&:to_i).freeze
    phase_settings = {}
    [0,1,2,3,4].permutation do |perm|
      last_output_signal = 0
      perm.each do |phase|
        last_output_signal = compute_amp(program.dup, phase, last_output_signal)
      end
      phase_settings[perm] = last_output_signal
    end

    phase_settings.max_by{ |k,v| v }[1]
  end

  def resolve(m, a, program)
    m == 0 ? program[a] : a
  end

  def compute_amp(program, phase, input)
    prog_input  = [phase, input]
    prog_output = []

    idx = 0
    loop do
      opcode = program[idx]
      m = Array(opcode.digits[2..-1])
      m << 0 while m.size < 3 # pad it
      opcode = opcode % 100

      case opcode
      when 1 # Add
        a, b, c = program.slice(idx+1, 3)
        program[c] = resolve(m[0], a, program) + resolve(m[1], b, program)
        idx += 4
      when 2 # Multiply
        a, b, c = program.slice(idx+1, 3)
        program[c] = resolve(m[0], a, program) * resolve(m[1], b, program)
        idx += 4
      when 3 # Ingest input
        a = program.slice(idx+1)
        program[a] = prog_input.shift
        idx += 2
      when 4 # Output
        a = program.slice(idx+1)
        prog_output << resolve(m[0], a, program)
        idx += 2
      when 5 # Jump-if-true
        a, b = program.slice(idx+1, 2)
        if resolve(m[0], a, program) != 0
          idx = resolve(m[1], b, program)
        else
          idx += 3
        end
      when 6 # Jump-if-false
        a, b = program.slice(idx+1, 2)
        if resolve(m[0], a, program) == 0
          idx = resolve(m[1], b, program)
        else
          idx += 3
        end
      when 7 # Less than
        a, b, c = program.slice(idx+1, 3)
        program[c] = resolve(m[0], a, program) < resolve(m[1], b, program) ? 1 : 0
        idx += 4
      when 8 # Equals
        a, b, c = program.slice(idx+1, 3)
        program[c] = resolve(m[0], a, program) == resolve(m[1], b, program) ? 1 : 0
        idx += 4
      when 99
        break
      end
    end

    prog_output.last
  end
end
