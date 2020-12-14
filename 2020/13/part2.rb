require_relative "../puzzle"

class Day13P1 < Puzzle

  class Bus
    attr_accessor :id, :seq

    def initialize(id, seq)
      @id = id
      @seq = seq
    end

    def in_seq_after?(t)
      (t + seq) % id == 0
    end
  end

  def test_cases
    { # {input => expected}
      ['_', '17,x,13,19'] => 3417,
      ['_', '67,7,59,61'] => 754018,
      ['_', '67,x,7,59,61'] => 779210,
      ['_', '67,7,x,59,61'] => 1261476,
      ['_', '1789,37,47,1889'] => 1202161486,
      ['939', '7,13,x,x,59,x,31,19'] => 1068781
    }
  end

  def solve(input, testing: false)
    buses = input[1].split(",").map(&:to_i).map.with_index do |b, i|
      Bus.new(b, i) if b > 0
    end.compact

    largest_bus = buses.max_by { |b| b.id }
    start_at = largest_bus.id

    t = 0
    interval = 1 # time between sequencial buses
    buses.each do |bus|
      t += interval until bus.in_seq_after?(t)
      interval *= bus.id
    end

    t
  end
end
