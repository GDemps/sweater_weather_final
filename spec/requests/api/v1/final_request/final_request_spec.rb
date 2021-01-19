require 'rails_helper'

describe 'The final endpoint' do
  it 'can return destination city, travel time, and food', :vcr do
    get '/api/v1/munchies', params: {start: 'denver,co', end: 'pueblo, co'}

    expect(response).to be_successful
    expect(response.status).to eq(200)

    destination = JSON.parse(response.body, symbolize_names: true)

    require "pry"
    binding.pry
    # expect(forecast[:data][:type]).to eq('forecast')
    # expect(forecast[:data][:attributes]).to have_key(:current_weather)
    # expect(forecast[:data][:attributes]).to have_key(:hourly_weather)
    # expect(forecast[:data][:attributes]).to have_key(:daily_weather)
  end
end
