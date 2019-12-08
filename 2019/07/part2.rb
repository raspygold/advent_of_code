require_relative "../puzzle"
class Day7P2 < Puzzle
  def solve(input, testing: false)
    program = input.split(',').map(&:to_i).freeze
    phase_settings = {}
    [5,6,7,8,9].permutation do |perm|
      amps = perm.map do |phase|
        Amp.new(program.dup, phase)
      end
      # Link the amps up
      amps[0].link_to(amps[1])
      amps[1].link_to(amps[2])
      amps[2].link_to(amps[3])
      amps[3].link_to(amps[4])
      amps[4].link_to(amps[0])

      amps[0].input << 0

      run_amps = amps.map do |amp|
        Thread.new { amp.run }
      end
      run_amps.each(&:join)

      phase_settings[perm] = amps[4].outputs.last
    end

    phase_settings.max_by{ |k,v| v }[1]
  end

  class Amp
    attr_accessor :input
    attr_reader   :outputs

    def initialize(program, phase)
      @program = program
      @input = [phase]
      @outputs = []
    end

    def link_to(output_to_amp)
      @output_to_amp = output_to_amp
    end

    def run
      idx = 0
      loop do
        opcode = @program[idx]
        m = Array(opcode.digits[2..-1])
        m << 0 while m.size < 3 # pad it
        opcode = opcode % 100

        case opcode
        when 1 # Add
          a, b, c = @program.slice(idx+1, 3)
          @program[c] = resolve(m[0], a) + resolve(m[1], b)
          idx += 4
        when 2 # Multiply
          a, b, c = @program.slice(idx+1, 3)
          @program[c] = resolve(m[0], a) * resolve(m[1], b)
          idx += 4
        when 3 # Ingest input
          a = @program.slice(idx+1)

          loop do # Busy wait for an input if we need to
            break if @input.any?
          end

          @program[a] = @input.shift
          idx += 2
        when 4 # Output
          a = @program.slice(idx+1)
          handle_output(resolve(m[0], a))
          idx += 2
        when 5 # Jump-if-true
          a, b = @program.slice(idx+1, 2)
          if resolve(m[0], a) != 0
            idx = resolve(m[1], b)
          else
            idx += 3
          end
        when 6 # Jump-if-false
          a, b = @program.slice(idx+1, 2)
          if resolve(m[0], a) == 0
            idx = resolve(m[1], b)
          else
            idx += 3
          end
        when 7 # Less than
          a, b, c = @program.slice(idx+1, 3)
          @program[c] = resolve(m[0], a) < resolve(m[1], b) ? 1 : 0
          idx += 4
        when 8 # Equals
          a, b, c = @program.slice(idx+1, 3)
          @program[c] = resolve(m[0], a) == resolve(m[1], b) ? 1 : 0
          idx += 4
        when 99
          break
        end
      end
    end

    private
    def resolve(m, a)
      m == 0 ? @program[a] : a
    end

    def handle_output(output)
      @outputs << output
      @output_to_amp.input << output
    end
  end
end
