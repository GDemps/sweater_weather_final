require 'rails_helper'

describe 'The forecast endpoint' do
  it 'returns the weather for a city', :vcr do
    get '/api/v1/forecast', params: {location: 'denver,co'}

    expect(response).to be_successful
    expect(response.status).to eq(200)

    forecast = JSON.parse(response.body, symbolize_names: true)

    expect(forecast[:data][:type]).to eq('forecast')
    expect(forecast[:data][:attributes]).to have_key(:current_weather)
    expect(forecast[:data][:attributes]).to have_key(:hourly_weather)
    expect(forecast[:data][:attributes]).to have_key(:daily_weather)
  end

  it 'retuns the weather for another city', :vcr do
    get '/api/v1/forecast', params: {location: 'Florence, AL'}

    expect(response).to be_successful
    expect(response.status).to eq(200)

    forecast = JSON.parse(response.body, symbolize_names: true)

    expect(forecast[:data][:type]).to eq('forecast')
    expect(forecast[:data][:attributes]).to have_key(:current_weather)
    expect(forecast[:data][:attributes]).to have_key(:hourly_weather)
    expect(forecast[:data][:attributes]).to have_key(:daily_weather)
  end
end
