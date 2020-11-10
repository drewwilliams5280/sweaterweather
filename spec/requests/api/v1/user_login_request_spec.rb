require 'rails_helper'

describe "Users API" do
  it "can login as a registered user with correct credentials" do
    user_params = ({
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
     })
     headers = {"CONTENT_TYPE" => "application/json"}
     post "/api/v1/users", headers: headers, params: JSON.generate(user_params)
     
     login_params = ({
      "email": "whatever@example.com",
      "password": "password"
     })
     headers = {"CONTENT_TYPE" => "application/json"}
     post "/api/v1/sessions", headers: headers, params: JSON.generate(login_params)
     
    expect(response).to be_successful
    expect(response.status).to eq(200)
    json = JSON.parse(response.body, symbolize_names: true)
    expect(json).to be_a Hash
    expect(json).to have_key(:data)
    expect(json[:data]).to have_key(:id)
    expect(json[:data]).to have_key(:type)
    expect(json[:data]).to have_key(:attributes)
    expect(json[:data][:attributes]).to have_key(:id)
    expect(json[:data][:attributes]).to have_key(:email)
    expect(json[:data][:attributes][:email]).to eq(user_params[:email])
  end

  it "can give 400 status for bad user login credentials" do
    user_params = ({
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
     })
     headers = {"CONTENT_TYPE" => "application/json"}
     post "/api/v1/users", headers: headers, params: JSON.generate(user_params)
     
     login_params = ({
      "email": "whatever@example.com",
      "password": "passwordddddddd"
     })
     headers = {"CONTENT_TYPE" => "application/json"}
     post "/api/v1/sessions", headers: headers, params: JSON.generate(login_params)
     json = JSON.parse(response.body, symbolize_names: true)
     expect(response.status).to eq(400)
     expect(json).to have_key(:error)
     expect(json[:error]).to eq("Login credentials incorrect.")
   end
end