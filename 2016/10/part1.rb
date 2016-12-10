#!/usr/bin/env ruby
file_path = File.expand_path("../input", __FILE__)
input     = File.readlines(file_path)

class Recipient
  attr_reader :id, :chips

  def initialize(id)
    @id = id
    @chips = []
  end

  def receive(chip)
    @chips << chip
  end
end

class Output < Recipient; end

class Bot < Recipient
  def initialize(id)
    @id = id
    @chips = []
  end

  def set_recipients(low_recipient, high_recipient)
    @low_recipient = low_recipient
    @high_recipient = high_recipient
  end

  def receive(chip)
    super(chip)

    offload_chips if @chips.size > 1
  end

  def offload_chips
    @chips.sort!

    raise "It's me, Bot #{@id}!" if @chips == [17, 61]

    @low_recipient.receive(@chips.shift)
    @high_recipient.receive(@chips.shift)
  end
end

outputs = Hash.new { |h, k| h[k] = Output.new(k) }
bots    = Hash.new { |h, k| h[k] = Bot.new(k) }
bot_responsible = nil

value_instructions   = input.select { |instruction| instruction.start_with?("value ") }
offload_instructions = input.select { |instruction| instruction.start_with?("bot ") }

offload_instructions.each do |instruction|
  giver_id, low_receiver_type, low_receiver_id, high_receiver_type, high_receiver_id = /bot (\d+) gives low to (output|bot) (\d+) and high to (output|bot) (\d+)/.match(instruction).captures
  giver_id, low_receiver_id, high_receiver_id = [giver_id, low_receiver_id, high_receiver_id].map(&:to_i)

  bot_giver = bots[giver_id]
  low_receiver  = ((low_receiver_type == "bot")  ? bots : outputs)[low_receiver_id]
  high_receiver = ((high_receiver_type == "bot") ? bots : outputs)[high_receiver_id]

  bot_giver.set_recipients(low_receiver, high_receiver)
end

value_instructions.each do |instruction|
  value, bot_id = /value (\d+) goes to bot (\d+)/.match(instruction).captures.map(&:to_i)
  bots[bot_id].receive(value)
end


puts "", "The number of the bot that is responsible for comparing value-61 microchips with value-17 microchips is: #{bot_responsible}"
