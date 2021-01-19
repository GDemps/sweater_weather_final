require 'rails_helper'

describe 'users login endpoint' do
  it 'returns a user response with an id, email, and api_key' do
    user = create(:user, password: '12345')
    user_body = {
                    "email": user.email,
                    "password": "12345"
                  }
    post '/api/v1/sessions', params: user_body.to_json, headers: { "CONTENT_TYPE" => "application/json" }

    expect(response).to be_successful
    expect(response.status).to eq(200)

    user_response = JSON.parse(response.body, symbolize_names: true)
    expect(user_response[:data][:type]).to eq('users')
    expect(user_response[:data][:id]).to eq(user.id.to_s)
    expect(user_response[:data][:attributes][:email]).to eq(user.email)
    expect(user_response[:data][:attributes][:api_key]).to eq(user.api_key)
  end

  it 'returns a 400 if it fails to authenticate' do
    user = create(:user, password: '12345')
    user_body = {
                    "email": user.email,
                    "password": "wrong_password"
                  }
    post '/api/v1/sessions', params: user_body.to_json, headers: { "CONTENT_TYPE" => "application/json" }

    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    error_response = JSON.parse(response.body, symbolize_names: true)
    expect(error_response[:data][:type]).to eq('error')
    expect(error_response[:data][:error_message]).to eq("Credential error")
  end
end
