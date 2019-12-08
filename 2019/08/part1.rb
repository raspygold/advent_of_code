require_relative "../puzzle"
class Day8P1 < Puzzle
  def solve(input, testing: false)
    image = []
    w = 25
    h = 6
    layers = input.chars.each_slice(w * h).to_a
    layer = layers.min_by { |l| l.count { |x| x == "0" } }
    layer.count { |x| x == "1" } * layer.count { |x| x == "2" }
  end
end
