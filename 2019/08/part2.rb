require_relative "../puzzle"
class Day8P2 < Puzzle
  def resolve_pixel(layers_pixels)
    layers_pixels.each do |p|
      rp = { "0" => " ", "1" => "▀" }[p].tap { |x| return x if x }
    end
  end

  def solve(input, testing: false)
    image = []
    w = 25
    h = 6
    layers = input.chars.each_slice(w * h).to_a
    rendered_image = layers.first.map.with_index do |_, i|
      resolve_pixel(layers.map { |l| l[i] })
    end

    rendered_image.each_slice(25).each do |r|
      puts r.join
    end
  end
end
