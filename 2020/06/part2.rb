require_relative "../puzzle"
class Day06P2 < Puzzle
  def test_cases
    { # {input => expected}
      ['abcx'] => 4,
      ['abcy'] => 4,
      ['abcz'] => 4,
      [
        'abcx',
        'abcy',
        'abcz'
      ] => 3,
      [
        'abc',
        '',
        'a',
        'b',
        'c',
        '',
        'ab',
        'ac',
        '',
        'a',
        'a',
        'a',
        'a',
        '',
        'b'
      ] => 6
    }
  end

  def solve(input, testing: false)
    group_answers = input.join('\n').split('\n\n')
    group_answers.map do |answer_group|
      answers = answer_group.split('\n')
      answer_frequency = answers.join.each_char.with_object(Hash.new(0)) { |c, m| m[c]+=1 }

      answer_frequency.count { |k, v| v == answers.size }
    end.reduce(&:+)
  end
end
