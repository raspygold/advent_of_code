require_relative "../puzzle"

class Day16P1 < Puzzle

  def test_cases
    { # {input => expected}
    }
  end

  def parse_information(info)
    rules = {}
    loop do
      line = info.shift
      break if line.empty?

      rp = line.scan(/([a-z ]+): (\d+)-(\d+) or (\d+)-(\d+)/).first
      rules[rp[0]] = [rp[1].to_i..rp[2].to_i, rp[3].to_i..rp[4].to_i]
    end
    info.shift(1)
    my_ticket = info.shift.split(',').map(&:to_i)
    info.shift(2)
    other_tickets = info.map do |numbers|
      numbers.split(',').map(&:to_i)
    end

    [rules, my_ticket, other_tickets]
  end

  def solve(input, testing: false)
    rules, my_ticket, other_tickets = parse_information(input)
    valid_tickets = other_tickets.select do |ticket|
      ticket.all? do |n|
        rules.values.flatten.any? { |r| r.include?(n) }
      end
    end

    grouped_values = valid_tickets.first.map.with_index do |_, i|
      valid_tickets.map { |t| t[i] }
    end

    possible_rules = grouped_values.map do |vs|
      matched_rules = rules.to_a.select do |name, ranges|
        vs.all? { |v| ranges.any? { |r| r.include?(v) } }
      end
      matched_rules.map { |name, _| name }
    end

    loop do
      possible_rules.size.times do |i|
        if possible_rules[i].one?
          (possible_rules - [possible_rules[i]]).each do |rs|
            rs.delete(possible_rules[i].first)
          end
        end
      end
      break if possible_rules.all? { |r| r.one? }
    end

    possible_rules.flatten.map.with_index do |r, i|
      r.include?('departure') ? my_ticket[i] : nil
    end.compact.reduce(&:*)
  end
end
