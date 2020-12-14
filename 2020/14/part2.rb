require_relative "../puzzle"

class Day14P2 < Puzzle

  def test_cases
    { # {input => expected}
      ['mask = 000000000000000000000000000000X1001X',
       'mem[42] = 100',
       'mask = 00000000000000000000000000000000X0XX',
       'mem[26] = 1'] => 208
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
        bin_addr = addr.to_s(2).rjust(36, '0')
        masked_bin_addr = bin_addr.chars.map.with_index do |c, i|
          mask[i] == 'X' ? c : mask[i]
          case mask[i]
          when '0'
            c
          when '1'
            mask[i]
          when 'X'
            'X'
          end
        end.join

        build_fluctuating_address(masked_bin_addr).each do |addr|
          mem[addr] = dec_val
        end
      end
    end

    mem.values.reduce(&:+)
  end

  def build_fluctuating_address(masked_bin_addr)
    addrs = [masked_bin_addr]
    loop do
      x_idx = addrs.first.index('X') # they'll all have the same number of Xs
      break unless x_idx

      last_addrs = addrs.dup
      addrs = last_addrs.map do |addr|
        [addr.sub('X', '0'), addr.sub('X', '1')]
      end.flatten
    end

    addrs
  end
end
