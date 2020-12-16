require_relative "../puzzle"

class Day16P1 < Puzzle

  def test_cases
    { # {input => expected}
      ['class: 1-3 or 5-7',
       'row: 6-11 or 33-44',
       'seat: 13-40 or 45-50',
       '',
       'your ticket:',
       '7,1,14',
       '',
       'nearby tickets:',
       '7,3,47',
       '40,4,50',
       '55,2,20',
       '38,6,12'] => 4 + 55 + 12
    }
  end

  def parse_information(info)
    rules = {}
    loop do
      line = info.shift
      break if line.empty?

      rp = line.scan(/([a-z]+): (\d+)-(\d+) or (\d+)-(\d+)/).first
      rules[rp[0]] = [rp[1].to_i..rp[2].to_i, rp[3].to_i..rp[4].to_i]
    end
    info.shift(2)
    my_ticket = info.shift.split(',').map(&:to_i)
    info.shift(2)
    other_tickets = info.map do |numbers|
      numbers.split(',').map(&:to_i)
    end

    [rules, my_ticket, other_tickets]
  end

  def solve(input, testing: false)
    rules, my_ticket, other_tickets = parse_information(input)
    scan_error_rate = 0
    other_tickets.each do |ticket|
      ticket.each do |n|
        scan_error_rate += n unless rules.values.flatten.any? { |r| r.include?(n) }
      end
    end

    scan_error_rate
  end
end
