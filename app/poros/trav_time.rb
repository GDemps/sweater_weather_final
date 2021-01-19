class TravTime
  attr_reader :travel_time

  def initialize(tt)
    @travel_time = format_time(tt)
  end

  private

  def format_time(tt)
    raw = tt[:route][:formattedTime]
    "#{raw[0,2]} hours #{raw[3,2]} minutes"
  end
end
