require_relative "../puzzle"

class Day14P1 < Puzzle

  def test_cases
    { # {input => expected}
      ['mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X',
       'mem[8] = 11',
       'mem[7] = 101',
       'mem[8] = 0'] => 165
    }
  end

  def solve(input, testing: false)
    mask = []
    mem = Hash.new(0)
    input.each do |instr|
      case instr
      when /mask/
        mask = instr.scan(/[X\d]+/).first.chars
      when /mem/
        addr, dec_val = instr.scan(/\d+/).map(&:to_i)
        bin_val = dec_val.to_s(2).rjust(36, '0')
        masked_bin_val = bin_val.chars.map.with_index do |c, i|
          mask[i] == 'X' ? c : mask[i]
        end.join

        mem[addr] = masked_bin_val.to_i(2)
      end
    end

    mem.values.reduce(&:+)
  end
end
