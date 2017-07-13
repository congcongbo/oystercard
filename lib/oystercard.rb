class Oystercard
  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_CHARGE = 1
  attr_reader :balance, :entry_station, :exit_station

  def initialize
    @balance = 0
    @entry_station = nil
    @exit_station = nil
  end

  def top_up(amount)
    fail "You tried to increase your balance by #{Oystercard::MAX_BALANCE + 1}. This is impossible! The maximum limit is £#{Oystercard::MAX_BALANCE}!" if balance + amount > MAX_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in(station)
    fail "You must have a minimum balance of £#{MIN_BALANCE}!" if balance < MIN_BALANCE
    @entry_station = station
  end

  def in_journey?
    entry_station != nil
  end

  def touch_out(station)
    @entry_station = nil
    @exit_station = station
    deduct(MIN_CHARGE)
  end
end

private

def deduct(amount)
  @balance -= amount
end
