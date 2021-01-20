require 'rails_helper'

describe 'The retake endpoint' do
  it 'returns end city, estimated travel time, name/address of restaurant, and arrival forecast', :vcr do
    get '/api/v1/foodie', params: {start: 'denver,co', end: 'pueblo,co', search: 'burgers'}
    expect(response).to be_successful
    expect(response.status).to eq(200)

    retake_data = JSON.parse(response.body, symbolize_names: true)

    expect(retake_data[:data][:attributes]).to have_key(:end_location)
    expect(retake_data[:data][:attributes][:end_location]).to eq("Pueblo, CO")

    expect(retake_data[:data][:attributes]).to have_key(:travel_time)
    expect(retake_data[:data][:attributes][:travel_time]).to be_a(String)

    expect(retake_data[:data][:attributes]).to have_key(:forecast)
    expect(retake_data[:data][:attributes][:forecast]).to have_key(:summary)
    expect(retake_data[:data][:attributes][:forecast][:summary]).to be_a(String)

    expect(retake_data[:data][:attributes][:forecast]).to have_key(:temperature)

    expect(retake_data[:data][:attributes][:restaurant][:name]).to eq("Bingo Burger")
    expect(retake_data[:data][:attributes][:restaurant][:address]).to eq("101 Central Plaza 81003")
  end
end
