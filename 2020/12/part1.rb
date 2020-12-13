require_relative "../puzzle"

class Day12P1 < Puzzle

  DIRECTIONS = {
    'E' => [ 0,  1],
    'S' => [ 1,  0],
    'W' => [ 0, -1],
    'N' => [-1,  0]
  }.freeze

  ROTATIONS = {
    'L' => -1,
    'R' =>  1
  }.freeze

  def test_cases
    { # {input => expected}
      ['F10', 'N3', 'F7', 'R90', 'F11'] => 25
    }
  end

  def solve(input, testing: false)
    pos = [0, 0]
    dirs = DIRECTIONS.keys
    input.each do |instr|
      d, n = instr.scan(/([NSEWLRF])(\d+)/).flatten
      n = n.to_i

      case d
      when /[NESW]/ # move
        mov = DIRECTIONS[d].map { |c| c * n }
        pos = [pos[0] + mov[0], pos[1] + mov[1]]
      when /[LR]/ # turn
        factor = ROTATIONS[d] * (n / 90)
        dirs.rotate!(factor)
      when /[F]/ # forward
        mov = DIRECTIONS[dirs.first].map { |c| c * n }
        pos = [pos[0] + mov[0], pos[1] + mov[1]]
      end
    end

    pos.map(&:abs).reduce(&:+)
  end
end
