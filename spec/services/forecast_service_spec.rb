require 'rails_helper'

describe 'WeatherService' do
  it 'returns weather data', :vcr do
    location = LatLonFacade.get_coordinates('denver,co')
    response = WeatherService.get_weather(location)
    expect(response).to have_key(:current)
    expect(response).to have_key(:hourly)
    expect(response).to have_key(:daily)
  end
end
