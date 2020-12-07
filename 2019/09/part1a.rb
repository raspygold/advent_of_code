require_relative "../puzzle"
class Day9P1 < Puzzle
  def test_cases
    { # {input => expected}
      # "109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99" => 99,
      # "1102,34915192,34915192,7,4,7,99,0" => 1219070632396864,
      # "104,1125899906842624,99" => 1125899906842624
    }
  end

  def solve(input, testing: false)
    instructions = input.split(',').map(&:to_i)
    instructions.freeze
    intcode_program = IntcodeProgram.new(instructions.dup, [1])
    intcode_program.run

    puts intcode_program.outputs.inspect
    intcode_program.outputs.last
  end

  class IntcodeProgram
    attr_reader :outputs

    OPS = {
      1  => :add,
      2  => :multiply,
      3  => :ingest,
      4  => :output,
      5  => :jump_if_true,
      6  => :jump_if_false,
      7  => :less_than,
      8  => :equals,
      9  => :adjust_relative_base
    }

    # TODO: Rewrite how we're updating @program[c] to behave better with modes — broken for relative base
    def add(a,b,c); @program[c] = a + b; end
    def multiply(a,b,c); @program[c] = a * b; end
    def ingest(a); @program[a] = @input.shift; end
    def output(a); @outputs << a; end
    def jump_if_true(a,b); @idx = b if a != 0; end
    def jump_if_false(a,b); @idx = b if a == 0; end
    def less_than(a,b,c); @program[c] = a < b ? 1 : 0; end
    def equals(a,b,c); @program[c] = a == b ? 1 : 0; end
    def adjust_relative_base(a); @r_base += a; end

    def initialize(instructions, input)
      @program = instructions.map.with_index.with_object(Hash.new(0)) do |(instr, i), hsh|
        hsh[i] = instr
      end
      @input = Array(input)
      @outputs = []
    end

    def run
      @idx = @r_base = 0
      loop do
        instruction = @program[@idx]
        opcode = instruction % 100
        break if opcode == 99

        pre_instr_idx = @idx
        fun = method(OPS[opcode])
        modes = Array(instruction.digits[2..-1])
        modes << 0 while modes.size < fun.arity # pad it
        # if [1,2,3,7,8].include?(opcode) && modes[-1] != 1
        #   puts "INSTR: #{instruction}"
        #   puts "PRE: #{modes.inspect}"
        #   modes[-1] = 1
        #   puts "POST: #{modes.inspect}"
        # end
        puts "INSTR: #{[instruction, @program.slice(@idx+1, fun.arity)].inspect}"
        puts "MODES: #{modes.inspect}"
        args = Array.new(fun.arity) do |i|
          x = @program[@idx + 1 + i]
          {
            0 => i <= 2 ? @program[x] : x,
            1 => x,
            2 => i <= 2 ? @program[@r_base + x] : @r_base + x,
          }[modes[i]]
        end
        fun.call(*args)
        @idx += fun.arity + 1 unless @idx != pre_instr_idx # index was updated so leave it be
        # puts "OUTPUTS: #{outputs.inspect}"
        # puts ({ idx: @idx, r_base: @r_base }).inspect
        # puts
      end
    end
  end
end
