require 'rails_helper'

RSpec.describe ForecastFacade, :vcr do
  it 'returns a Forecast object when called with just location' do
    location = 'denver, co'
    forecast = ForecastFacade.get_forecast(location)
    expect(forecast).to be_a Forecast
    expect(forecast.current_weather).to be_a CurrentWeather
    expect(forecast.current_weather.temperature).to be_a Float
    expect(forecast.current_weather.conditions).to be_a String
    expect(forecast.daily_weather).to be_a Array
    expect(forecast.daily_weather.count).to eq(5)
    expect(forecast.daily_weather.first).to be_a DailyWeather
    expect(forecast.hourly_weather).to be_a Array
    expect(forecast.hourly_weather.count).to eq(8)
    expect(forecast.hourly_weather.first).to be_a HourlyWeather
  end
end
