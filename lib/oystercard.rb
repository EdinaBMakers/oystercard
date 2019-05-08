class Oystercard
  attr_reader :balance, :entry_station, :journey_history
  DEFAULT_MAX_BALANCE = 90
  SINGLE_FARE = 1

  def initialize
    @balance = 0
    @entry_station = nil
    @journey_history = []
  end

  def top_up(amount)
    raise "Balance can't be more than #{Oystercard::DEFAULT_MAX_BALANCE}" \
    if exceed_max_balance?(amount)

    @balance += amount
  end

  def in_journey?
    @entry_station != nil
  end

  def touch_in(station)
    raise "Balance is not enough for a single journey" if under_minimum_balance?
    @entry_station = station
  end

  def touch_out
    deduct(SINGLE_FARE)
    @entry_station = nil
  end

  private

  def exceed_max_balance?(amount)
    balance + amount > DEFAULT_MAX_BALANCE
  end

  def under_minimum_balance?
    @balance < SINGLE_FARE
  end

  def deduct(amount)
    @balance -= amount
  end
end
