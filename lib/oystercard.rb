class Oystercard
  attr_reader :balance
  DEFAULT_MAX_BALANCE = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    raise "Balance can't be more than #{Oystercard::DEFAULT_MAX_BALANCE}" \
    if exceed_max_balance?(amount)

    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    raise "Balance is not enough for a single journey" if under_minimum_balance?
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  private

  def exceed_max_balance?(amount)
    balance + amount > DEFAULT_MAX_BALANCE
  end

  def under_minimum_balance?
    @balance < MINIMUM_BALANCE
  end
end
