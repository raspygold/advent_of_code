require_relative "../puzzle"

class Day11P1 < Puzzle
  FLOOR = '.'
  EMPTY = 'L'
  TAKEN = '#'

  attr_accessor :previous_map, :next_map

  def test_cases
    { # {input => expected}
      ['L.LL.LL.LL',
       'LLLLLLL.LL',
       'L.L.L..L..',
       'LLLL.LL.LL',
       'L.LL.LL.LL',
       'L.LLLLL.LL',
       '..L.L.....',
       'LLLLLLLLLL',
       'L.LLLLLL.L',
       'L.LLLLL.LL'] => 37
    }
  end

  def solve(input, testing: false)
    next_map = input.map(&:chars)
    @map_dimensions = [next_map.size, next_map.first.size]
    cycles = 0

    loop do
      previous_map = next_map
      next_map = Array.new(previous_map.size) { Array.new(previous_map.first.size) }
      @map_dimensions[0].times do |y|
        @map_dimensions[1].times do |x|
          next_map[y][x] = case previous_map[y][x]
          when FLOOR
            FLOOR
          when EMPTY
            all_empty = adjacent_seats(previous_map, y, x).none? { |s| s == TAKEN }
            all_empty ? TAKEN : EMPTY
          when TAKEN
            num_taken = adjacent_seats(previous_map, y, x).count { |s| s == TAKEN }
            num_taken < 4 ? TAKEN : EMPTY
          end
        end
      end

      break if next_map.map.with_index do |row, i|
        row == previous_map[i]
      end.all?

      cycles += 1
    end

    next_map.map { |r| r.count { |s| s == TAKEN }}.reduce(&:+)
  end

  def adjacent_seats(map, y, x)
    possible_mods = ([-1,0,1].product([-1,0,1]) - [[0,0]]).select do |mod|
      (y + mod[0]).between?(0, @map_dimensions[0]-1) && (x + mod[1]).between?(0, @map_dimensions[1]-1)
    end

    possible_mods.map do |mod|
      map[y + mod[0]][x + mod[1]]
    end
  end
end
