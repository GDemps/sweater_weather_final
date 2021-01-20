require 'rails_helper'

describe 'LatLon Maqquest Poro' do
  it 'returns a location object', :vcr do
    location_arg = 'denver, co'
    location = LatLonService.new.get_coordinates(location_arg)
    expect(location.class).to eq(Hash)
    expect(location[:results][0][:locations][0][:adminArea5]).to eq("Denver")
  end
end
