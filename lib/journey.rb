class Journey
  attr_reader :entry_station, :exit_station
  def initialize(entry_station)
    @entry_station = entry_station
  end

  def exit(station)
    @exit_station = station
  end

  def journey_log
    {entry: @entry_station, exit: @exit_station}
  end

  def complete?
    !!@exit_station
  end

  def fare
    return 1 if complete?
    6
  end
end
