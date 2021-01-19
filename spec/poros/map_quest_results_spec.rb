require 'rails_helper'

describe 'MapQuest Results' do
  it 'returns a location object', :vcr do
    location_arg = 'denver, co'
    location = LatLonService.new.get_coordinates(location_arg)
    require "pry"
    binding.pry
    expect(location.class).to eq(LatLon)
    expect(location.name).to eq('Denver, CO US')
  end
end
