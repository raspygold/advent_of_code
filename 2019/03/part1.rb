require_relative "../puzzle"
class Day3Part1 < Puzzle
  def test_cases
    { # {input => expected}
      ["R8,U5,L5,D3", "U7,R6,D4,L4"] => 6,
      ["R75,D30,R83,U83,L12,D49,R71,U7,L72", "U62,R66,U55,R34,D71,R55,D58,R83"] => 159,
      ["R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51", "U98,R91,D20,R16,D67,R40,U7,R15,U6,R7"] => 135
    }
  end

  # Use `testing` when the test cases behaviour differs
  def solve(input, testing: false)
    paths = input.map do |wire|
      build_path([[0,0]], wire)
    end
    x_at = (paths[0] & paths[1] - [[0, 0]])
    x_at.map { |c| c[0].abs + c[1].abs }.min
  end

  def build_path(path, wire)
    i = wire.index(",") || wire.length
    m = wire[0...i]
    r = wire[i+1..-1]
    d = m[0]
    n = m[1..-1].to_i # to_i strips the ,
    Array.new(n).map do
      path <<
        case d
        when "U"
          [path.last[0], path.last[1] - 1]
        when "D"
          [path.last[0], path.last[1] + 1]
        when "R"
          [path.last[0] + 1, path.last[1]]
        when "L"
          [path.last[0] - 1, path.last[1]]
        end
    end
    return path if r.nil?
    build_path(path, r)
  end
end
