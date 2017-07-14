require_relative 'journey.rb'

class Oystercard
  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_CHARGE = 1
  attr_reader :balance, :journeys, :journey

  def initialize
    @balance = 0
    @entry_station = nil
    @exit_station = nil
    @journeys = []
  end

  def entry_station
    return nil if @journey == nil
    @journey.entry_station
  end

  def exit_station
    @journey.exit_station
  end

  def top_up(amount)
    fail "You tried to increase your balance by #{Oystercard::MAX_BALANCE + 1}. This is impossible! The maximum limit is £#{Oystercard::MAX_BALANCE}!" if balance + amount > MAX_BALANCE
    @balance += amount
  end

  def deduct
    @balance -= @journey.fare
  end

  def touch_in(station)
    fail "You must have a minimum balance of £#{MIN_BALANCE}!" if balance < MIN_BALANCE
    @journey = Journey.new(station)
  end

  def in_journey?
    return false if @journey == nil
    !@journey.complete?
  end

  def touch_out(station)
    @journey.exit(station)
    deduct
    @journeys << {entry: entry_station, exit: exit_station}
  end

end
