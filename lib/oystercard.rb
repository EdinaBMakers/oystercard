class Oystercard
  attr_reader :balance
  DEFAULT_MAX_BALANCE = 90

  def initialize
    @balance = 0
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
    false
  end

  private

  def exceed_max_balance?(amount)
    balance + amount > DEFAULT_MAX_BALANCE
  end
end
