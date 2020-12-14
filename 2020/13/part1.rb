require_relative "../puzzle"

class Day13P1 < Puzzle

  class Bus
    attr_accessor :id

    def initialize(id)
      @id = id
    end

    def next_time_after(t)
      ((t / id) + 1) * id
    end
  end

  def test_cases
    { # {input => expected}
      ['939',
       '7,13,x,x,59,x,31,19'] => 295
    }
  end

  def solve(input, testing: false)
    earliest_time = input[0].to_i
    bus_ids = input[1].split(",").map(&:to_i).select { |b| b > 0}
    buses = bus_ids.map { |b| Bus.new(b) }

    next_bus = buses.min_by { |b| b.next_time_after(earliest_time) }

    next_bus.id * (next_bus.next_time_after(earliest_time) - earliest_time)
  end
end
