module Utils
  def read_input(file: "input", strip: true, ints: false)
    input = File.readlines(File.expand_path(file))
    input = input.map(&:strip) if strip
    input = input.map(&:to_i) if ints
    input = input.first if input.size == 1 # unwrap the array if it's just one line
    input
  end

  # test the solution attempt against the test data sets
  def test(input, expected)
    orig_desc = input.to_s.dup.freeze
    result = solve(input)

    input_sample = orig_desc.size > 10 ? "#{orig_desc.slice(0, 10)} ..." : orig_desc
    if result == expected
      puts "\nTest passed with input: #{input_sample}"
    else
      puts %Q(\nTest failed with input: #{input_sample}\n
  Expected: #{expected.inspect}\n\
    Actual: #{result.inspect}\n\n)
      exit
    end
  end
end
