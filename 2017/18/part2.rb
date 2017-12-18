#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.readlines(file_path)

class Program
  attr_reader :send_count

  def initialize(commands, id)
    @commands = commands
    @id = id
    @registers = Hash.new(0)
    @registers["p"] = id
    @command_idx = 0
    @receiving_into = nil
    @queue = []
    @send_count = 0
  end

  def connect(program)
    @connected_program = program
  end

  def blocked?
    idx_invalid? || (@receiving_into && @queue.empty?)
  end

  def idx_invalid?
    @command_idx < 0 && @command_idx >= @commands.size
  end

  def enqueue(value)
    @queue << value
  end

  def resolve(register_or_value)
    if (value = register_or_value.to_i).to_s == register_or_value # int
      value
    else # register
      @registers[register_or_value]
    end
  end

  def receive_value
    if (value = @queue.shift)
      @registers[@receiving_into] = value
      @receiving_into = nil

      value
    end
  end

  def process_command
    return if @blocked

    pieces = @commands[@command_idx].split(" ")
    command, register, register_or_value = pieces

    case command
    when "snd" # send value
      @connected_program.enqueue(resolve(register))
      @send_count += 1
    when "set" # set register
      @registers[register] = resolve(register_or_value)
    when "add" # add to register
      @registers[register] += resolve(register_or_value)
    when "mul" # multiply register
      @registers[register] *= resolve(register_or_value)
    when "mod" # modulus
      @registers[register] %= resolve(register_or_value)
    when "rcv" # receive value
      @receiving_into = register
      receive_value or return
    when "jgz" # jump instructions
      @command_idx += resolve(register_or_value) - 1 if resolve(register) > 0
    end

    @command_idx += 1
  end
end

commands = input.map(&:strip)
programs = [Program.new(commands, 0), Program.new(commands, 1)]
# set up connections
programs[0].connect(programs[1])
programs[1].connect(programs[0])

n = 0
loop do
  program = programs[n % 2]
  loop do
    program.process_command
    break if program.blocked?
  end
  n += 1

  break if programs.all?(&:blocked?) # deadlocked
end

puts programs[1].send_count

