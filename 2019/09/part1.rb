require_relative "../puzzle"
class Day9P1 < Puzzle
  def test_cases
    { # {input => expected}
      "109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99" => 99,
      "1102,34915192,34915192,7,4,7,99,0" => 1219070632396864,
      "104,1125899906842624,99" => 1125899906842624
    }
  end

  def solve(input, testing: false)
    instructions = input.split(',').map(&:to_i)
    instructions += ([0] * 1_000_000) # pad program memory heap
    instructions.freeze
    intcode_program = IntcodeProgram.new(instructions.dup, [1])
    intcode_program.run

    puts intcode_program.outputs.inspect
    intcode_program.outputs.last
  end

  class IntcodeProgram
    attr_reader   :outputs

    OPS = {
      1  => :add,
      2  => :mutliply,
      3  => :ingest,
      4  => :output,
      5  => :jump_if_true,
      6  => :jump_if_false,
      7  => :less_than,
      8  => :equals,
      9  => :adjust_relative_idx
    }

    def add(a,b,c); @program[c] = a + b; end
    def mulitply(a,b,c); @program[c] = a * b; end
    def ingest(a); @program[a] = @input.shift; end
    def output(a); @outputs << a; end
    def jump_if_true(a,b); @idx = b if a != 0; end
    def jump_if_false(a,b); @idx = b if a == 0; end
    def less_than(a,b,c); @program[c] = a < b ? 1 : 0; end
    def equals(a,b,c); @program[c] = a == b ? 1 : 0; end
    def adjust_relative_idx(a); @r_idx += a; end

    def initialize(program, input)
      @program = program
      @input = Array(input)
      @outputs = []
    end

    def run
      @idx = 0
      @r_idx = 0
      loop do
        instruction = @program[@idx]
        puts "INSTR: #{instruction}"
        m = Array(instruction.digits[2..-1])
        m << 0 while m.size < 3 # pad it
        opcode = instruction % 100

        break if opcode == 99
        # case opcode
        # when 1,2,3,4,5,6 # Add
          modes = Array(instruction.digits[2..-1])
          modes << 0 while modes.size < 3 # pad it
          fun = method(OPS[opcode])
          args = @program.slice(@idx+1, fun.arity).map.with_index do |x, i|
            {
              0 => @program[x],
              1 => x,
              2 => @program[@r_idx + x],
            }[modes[i]]
          end
          fun.call(*args)
          @idx += fun.arity + 1
          # exit
        # when 2 # Multiply
        #   a, b, c = @program.slice(@idx+1, 3)
        #   @program[c] = resolve(m[0], a) * resolve(m[1], b)
        #   @idx += 4
        # when 3 # Ingest input
        #   a = @program.slice(@idx+1)
        #   @program[a] = @input.shift
        #   @idx += 2
        # when 4 # Output
        #   a = @program.slice(@idx+1)
        #   @outputs << resolve(m[0], a)
        #   @idx += 2
        # when 5 # Jump-if-true
        #   a, b = @program.slice(@idx+1, 2)
        #   if resolve(m[0], a) != 0
        #     @idx = resolve(m[1], b)
        #   else
        #     @idx += 3
        #   end
        # when 6 # Jump-if-false
        #   a, b = @program.slice(@idx+1, 2)
        #   if resolve(m[0], a) == 0
        #     @idx = resolve(m[1], b)
        #   else
        #     @idx += 3
        #   end
        # when 7 # Less than
        #   a, b, c = @program.slice(@idx+1, 3)
        #   @program[c] = resolve(m[0], a) < resolve(m[1], b) ? 1 : 0
        #   @idx += 4
        # when 8 # Equals
        #   a, b, c = @program.slice(@idx+1, 3)
        #   @program[c] = resolve(m[0], a) == resolve(m[1], b) ? 1 : 0
        #   @idx += 4
        # when 9 # Adjust relative base
        #   a = @program.slice(@idx+1)
        #   @r_idx += resolve(m[0], a)
        #   @idx += 2
        # when 99
        #   break
        # end
      end
    end

    # private
    # def resolve(m, a)
    #   {
    #     0 => @program[a],
    #     1 => a,
    #     2 => @program[@r_idx + a],
    #   }[m]
    # end

    # def handle_output(output)
    #   @outputs << output
    # end
  end
end
