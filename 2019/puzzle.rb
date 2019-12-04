class Puzzle
  def initialize
    test_cases.each do |input, expected|
      test(input, expected)
    end
    puts "-"*50, ""
    puts "Solution:", solve(read_input)
  end

  def read_input(file: "input", strip: true) # Only works when called from dir with solutions
    input = File.readlines(File.expand_path(file, File.dirname($0)))
    input = input.map(&:strip) if strip
    input = input.first if input.size == 1 # unwrap the array if it's still just one value
    input
  end

  # test the solution attempt against the test data sets
  def test(input, expected)
    orig_desc = input.to_s.dup.freeze
    result = solve(input, testing: true)

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

at_exit do
  ObjectSpace
    .each_object(Class)
    .select { |c| c < Puzzle }
    .each(&:new)
end
