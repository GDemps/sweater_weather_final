require 'rails_helper'

describe 'RoadTrip PORO' do
  it 'has an origin, destination, travel_time, and forecast', :vcr do
    origin = "Denver, CO"
    destination = "Pueblo, CO"
    directions = LatLonFacade.new.directions(origin, destination)
    location = LatLonFacade.get_coordinates(destination)
    forecast = ForecastFacade.get_forecast(location)
    road_trip = RoadTrip.new(origin, destination, directions, forecast)

    expect(road_trip.start_city).to eq 'Denver, CO'
    expect(road_trip.end_city).to eq 'Pueblo, CO'
    expect(road_trip.travel_time).to be_a(String)
    expect(road_trip.weather_at_eta).to be_a(Hash)
  end
end
