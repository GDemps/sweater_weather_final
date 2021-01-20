require 'rails_helper'

describe 'Road trip endpoint' do
  it 'returns the origin, destination, travel time, and destination forecast', :vcr do
    user = create(:user)
    road_trip_body = {
                          "origin": "Denver, CO",
                          "destination": "Pueblo, CO",
                          "api_key": user.api_key
                      }
    post '/api/v1/road_trip', params: road_trip_body.to_json, headers: { "CONTENT_TYPE" => "application/json" }

    expect(response).to be_successful
    expect(response.status).to eq(200)

    road_trip = JSON.parse(response.body, symbolize_names: true)

    expect(road_trip[:data][:type]).to eq('road_trip')
    expect(road_trip[:data][:attributes]).to have_key(:start_city)
    expect(road_trip[:data][:attributes]).to have_key(:end_city)
    expect(road_trip[:data][:attributes]).to have_key(:travel_time)
    expect(road_trip[:data][:attributes]).to have_key(:weather_at_eta)
    require "pry"
    binding.pry
  end

  it 'returns a 401 if no API key is sent', :vcr do
    road_trip_body = {
                          "origin": "Denver, CO",
                          "destination": "Pueblo, CO",
                      }
    post '/api/v1/road_trip', params: road_trip_body.to_json, headers: { "CONTENT_TYPE" => "application/json" }

    expect(response).to_not be_successful
    expect(response.status).to eq(401)

    error_response = JSON.parse(response.body, symbolize_names: true)

    expect(error_response[:data][:type]).to eq('error')
    expect(error_response[:data][:error_message]).to eq('Credentials are bad')
  end

  it 'returns a 401 if an incorrect API key is sent', :vcr do
    road_trip_body = {
                          "origin": "Denver, CO",
                          "destination": "Pueblo, CO",
                          'api_key': SecureRandom.uuid
                      }
    post '/api/v1/road_trip', params: road_trip_body.to_json, headers: { "CONTENT_TYPE" => "application/json" }

    expect(response).to_not be_successful
    expect(response.status).to eq(401)

    error_response = JSON.parse(response.body, symbolize_names: true)

    expect(error_response[:data][:type]).to eq('error')
    expect(error_response[:data][:error_message]).to eq('Credentials are bad')
  end
end
