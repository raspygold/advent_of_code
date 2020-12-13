require_relative "../puzzle"

class Day12P2 < Puzzle

  DIRECTIONS = {
    'E' => [ 0,  1],
    'S' => [ 1,  0],
    'W' => [ 0, -1],
    'N' => [-1,  0]
  }.freeze

  def test_cases
    { # {input => expected}
      ['F10', 'N3', 'F7', 'R90', 'F11'] => 286
    }
  end

  def solve(input, testing: false)
    waypoint = [-1, 10]
    pos = [0, 0]
    dirs = DIRECTIONS.keys
    input.each do |instr|
      d, n = instr.scan(/([NSEWLRF])(\d+)/).flatten
      n = n.to_i

      case d
      when /[NESW]/ # move waypoint
        mov = DIRECTIONS[d].map { |c| c * n }
        waypoint = [waypoint[0] + mov[0], waypoint[1] + mov[1]]
      when /[LR]/ # rotate waypoint
        mod = if n == 180
          mov = [-1, -1]
          waypoint = [waypoint[0] * mov[0], waypoint[1] * mov[1]]
        elsif (d == 'R' && n == 90) || (d == 'L' && n == 270)
          mov = [1, -1]
          waypoint = [waypoint[1] * mov[0], waypoint[0] * mov[1]]
        elsif (d == 'R' && n == 270) || (d == 'L' && n == 90)
          mov = [-1, 1]
          waypoint = [waypoint[1] * mov[0], waypoint[0] * mov[1]]
        end # do nothing if d is 0
      when /[F]/ # move ship to waypoint
        pos = [pos[0] + (waypoint[0] * n), pos[1] + (waypoint[1] * n)]
      end
    end

    pos.map(&:abs).reduce(&:+)
  end
end
