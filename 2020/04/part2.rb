require_relative "../puzzle"
class Day04P2 < Puzzle
  def test_cases
    { # {input => expected}
      [
        'eyr:1972 cid:100',
        'hcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926',
        '',
        'iyr:2019',
        'hcl:#602927 eyr:1967 hgt:170cm',
        'ecl:grn pid:012533040 byr:1946',
        '',
        'hcl:dab227 iyr:2012',
        'ecl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277',
        '',
        'hgt:59cm ecl:zzz',
        'eyr:2038 hcl:74454a iyr:2023',
        'pid:3556412378 byr:2007'
      ] => 0,
      [
        'pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980',
        'hcl:#623a2f',
        '',
        'eyr:2029 ecl:blu cid:129 byr:1989',
        'iyr:2014 pid:896056539 hcl:#a97842 hgt:165cm',
        '',
        'hcl:#888785',
        'hgt:164cm byr:2001 iyr:2015 cid:88',
        'pid:545766238 ecl:hzl',
        'eyr:2022',
        '',
        'iyr:2010 hgt:158cm hcl:#b6652a ecl:blu byr:1944 eyr:2021 pid:093154719'
      ] => 4
    }
  end

  def solve(input, testing: false)
    validation_rules = {
      byr: -> (passport) do
        m = passport.match(/byr:(?<year>\d+)/)
        return unless m

        m[:year].to_i.between?(1920, 2002)
      end,

      iyr: -> (passport) do
        m = passport.match(/iyr:(?<year>\d+)/)
        return unless m

        m[:year].to_i.between?(2010, 2020)
      end,

      eyr: -> (passport) do
        m = passport.match(/eyr:(?<year>\d+)/)
        return unless m

        m[:year].to_i.between?(2020, 2030)
      end,

      hgt: -> (passport) do
        m = passport.match(/hgt:(?<size>\d+)(?<unit>[a-z]+)/)
        return unless m

        if m[:unit] == 'cm'
          m[:size].to_i.between?(150, 193)
        elsif m[:unit] == 'in'
          m[:size].to_i.between?(59, 76)
        end
      end,

      hcl: -> (passport) do
        m = passport.match(/hcl:#(?<value>[a-f|0-9]+)/)
        return unless m

        m[:value].size == 6
      end,

      ecl: -> (passport) do
        m = passport.match(/ecl:(?<color>[a-z]+)/)
        return unless m

        %w(amb blu brn gry grn hzl oth).include?(m[:color])
      end,

      pid: -> (passport) do
        m = passport.match(/pid:(?<value>[0-9]+)/)
        return unless m

        m[:value].size == 9
      end
    }

    passports = input.join('\n').split('\n\n').map { |p| p.gsub('\n', ' ')}

    valid_passports = passports.select do |passport|
      validation_rules.all? do |field, rule|
        rule.call(passport)
      end
    end

    valid_passports.size
  end
end
