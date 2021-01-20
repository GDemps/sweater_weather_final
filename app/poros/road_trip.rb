class RoadTrip
  attr_reader :start_city,
              :end_city,
              :travel_time,
              :real_time,
              :weather_at_eta,
              :id
  def initialize(origin, destination, directions, forecast)
    @start_city = origin
    @end_city = destination
    @travel_time = directions[:route][:formattedTime]
    @real_time = directions[:route][:realTime]
    @arrival_forecast = get_arrival_forecast(forecast, @real_time)
    @weather_at_eta = { temperature: @arrival_forecast.temperature, conditions: @arrival_forecast.conditions}
    @id = nil
  end

  private
  def get_arrival_forecast(forecast, time)
    hours = (time / 60.0 / 60).round(0)
    forecast.hourly_weather[hours - 1]
  end
end
