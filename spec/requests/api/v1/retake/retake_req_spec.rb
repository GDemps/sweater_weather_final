require 'rails_helper'

describe 'The retake endpoint' do
  it 'returns end city, estimated travel time, name/address of restaurant, and arrival forecast', :vcr do
    get '/api/v1/foodie', params: {start: 'denver,co', end: 'pueblo,co', search: 'burgers'}
    expect(response).to be_successful
    expect(response.status).to eq(200)

    retake_data = JSON.parse(response.body, symbolize_names: true)
    require "pry"
    binding.pry
    # expect(retake_data[:data][:attributes]).to have_key(:current_weather)
    # expect(retake_data[:data][:attributes]).to have_key(:hourly_weather)
    # expect(retake_data[:data][:attributes]).to have_key(:daily_weather)
  end
end
