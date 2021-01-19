require 'rails_helper'

describe 'users endpoint' do
  it 'returns a user response with an id, email, and api_key' do
    user_body = {
                    "email": "whatever@example.com",
                    "password": "password",
                    "password_confirmation": "password"
                  }
    post '/api/v1/users', params: user_body.to_json, headers: { "CONTENT_TYPE" => "application/json" }

    expect(response).to be_successful
    expect(response.status).to eq(201)

    user_response = JSON.parse(response.body, symbolize_names: true)
    expect(user_response[:data][:type]).to eq('users')
    expect(user_response[:data]).to have_key(:id)
    expect(user_response[:data][:attributes]).to have_key(:email)
    expect(user_response[:data][:attributes]).to have_key(:api_key)
  end

  it 'returns a 400 and description of failure for password_confirmation not matching' do
    user_body = {
                    "email": "whatever@example.com",
                    "password": "password",
                    "password_confirmation": "different_password"
                  }
    post '/api/v1/users', params: user_body.to_json, headers: { "CONTENT_TYPE" => "application/json" }

    expect(response.status).to eq(400)

    error_response = JSON.parse(response.body, symbolize_names: true)
    expect(error_response[:data][:type]).to eq('error')
    expect(error_response[:data][:error_message]).to eq("Password confirmation doesn't match Password")
  end

  it 'returns a 400 and description of failure for email being taken' do
    create(:user, email: "whatever@example.com")
    user_body = {
                    "email": "whatever@example.com",
                    "password": "password",
                    "password_confirmation": "password"
                  }
    post '/api/v1/users', params: user_body.to_json, headers: { "CONTENT_TYPE" => "application/json" }

    expect(response.status).to eq(400)

    error_response = JSON.parse(response.body, symbolize_names: true)
    expect(error_response[:data][:type]).to eq('error')
    expect(error_response[:data][:error_message]).to eq("Email has already been taken")
  end

  it 'returns a 400 and description of failure for missing fields' do
    user_body = {
                    "email": "",
                    "password": "password",
                    "password_confirmation": "password"
                  }
    post '/api/v1/users', params: user_body.to_json, headers: { "CONTENT_TYPE" => "application/json" }

    expect(response.status).to eq(400)

    error_response = JSON.parse(response.body, symbolize_names: true)
    expect(error_response[:data][:type]).to eq('error')
    expect(error_response[:data][:error_message]).to eq("Email can't be blank")
  end
end
