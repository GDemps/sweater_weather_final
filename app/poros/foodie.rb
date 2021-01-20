class Foodie
  attr_reader :id,
              :type,
              :attributes,
              :restaurant

  def initialize(directions, location, forecast, restaurant)
    @id = nil
    @type = 'foodie'
    @end_location = "#{directions[:route][:locations][1][:adminArea5]}, #{directions[:route][:locations][1][:adminArea3]}"
    @travel_time = directions[:route][:formattedTime]
    @real_time = directions[:route][:realTime]
    @arrival_forecast = get_arrival_forecast(forecast, @real_time)
    @forecast = { summary: @arrival_forecast.conditions, temperature: @arrival_forecast.temperature }
    @attributes = { end_location: @end_location, travel_time: @travel_time, forecast: @forecast }
    @restaurant = { name: restaurant.name, address: restaurant.address }
  end

  private
  def get_arrival_forecast(forecast, time)
    hours = (time / 60.0 / 60).round(0)
    forecast.hourly_weather[hours - 1]
  end
end
