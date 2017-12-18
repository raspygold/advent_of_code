#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.readlines(file_path)

registers = Hash.new(0)

def resolve_value(registers, register_or_value)
  if (value = register_or_value.to_i).to_s == register_or_value # int
    value
  else # register
    registers[register_or_value]
  end
end

commands = input.map(&:strip)
idx = 0
loop do
  command_str = commands[idx]
  pieces = command_str.split(" ")
  command, register, register_or_value = pieces

  case command
  when "snd" # play sound
    registers[:last_freq] = registers[register]
  when "set" # set register
    registers[register] = resolve_value(registers, register_or_value)
  when "add" # add to register
    registers[register] += resolve_value(registers, register_or_value)
  when "mul" # multiply register
    registers[register] *= resolve_value(registers, register_or_value)
  when "mod" # modulus
    registers[register] %= resolve_value(registers, register_or_value)
  when "rcv" # frequency of last sound
    if registers[register] != 0
      p registers[:last_freq]
      exit
    end
  when "jgz" # jump instructions
    idx += resolve_value(registers, register_or_value) - 1 if resolve_value(registers, register) > 0
  end

  idx += 1
  break unless idx >= 0 && idx < commands.size
end

