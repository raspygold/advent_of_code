module ChallengeUtils
  def read_input(filename)
    caller_path = caller[0].partition(":")[0]
    input_path  = File.expand_path(filename)
    input       = File.readlines(input_path).map(&:strip)
    input       = input.first if input.size == 1 # unwrap the array if it's just one line
    input
  end

  # test the solution attempt against the test data sets
  def test(input, expected_result)
    orig_input = input.to_s.dup.freeze
    result = solve(input)

    input_sample = orig_input.size > 10 ? "#{orig_input.slice(0, 10)} ..." : orig_input
    if result == expected_result
      puts "\nTest passed with input: #{input_sample}"
    else
      puts %Q(\nTest failed with input: #{input_sample}\n
  Expected: #{expected_result.inspect}\n\
    Actual: #{result.inspect}\n\n)
      exit
    end
  end
end
