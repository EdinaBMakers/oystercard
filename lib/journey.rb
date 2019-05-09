class Journey
  STANDARD_FARE = 1
  PENALTY_FARE = 6

  def start(station)
    @entry_station = station
  end

  def finish(station)
    @exit_station = station
  end

  def complete?
    started? && finished?
  end

  def fare
    complete? ? STANDARD_FARE : PENALTY_FARE
  end

  private

  def started?
    @entry_station != nil
  end

  def finished?
    @exit_station != nil
  end
end
