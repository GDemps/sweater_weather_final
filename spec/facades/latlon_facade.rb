require 'rails_helper'

RSpec.describe LatLonFacade, :vcr do
  it 'can take a location and return the coordinates of the location' do
    location = 'denver, co'
    latlon = LatLonFacade.get_coordinates(location)
    expect(latlon).to be_a LatLon
    expect(latlon.id).to be_nil
    expect(latlon.lat).to be_an Float
    expect(latlon.lat).to eq(39.738453)
    expect(latlon.lon).to be_an Float
    expect(latlon.lon).to eq(-104.984853)
    expect(latlon.name).to eq('Denver, CO US')
  end
end
