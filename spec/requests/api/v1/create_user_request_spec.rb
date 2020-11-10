require 'rails_helper'

describe "Users API" do
  it "can register/create a user" do
    user_params = ({
     "email": "whatever@example.com",
     "password": "password",
     "password_confirmation": "password"
    })
    headers = {"CONTENT_TYPE" => "application/json"}
    post "/api/v1/users", headers: headers, params: JSON.generate(user_params)
    expect(response).to be_successful
    expect(response.status).to eq(201)
    json = JSON.parse(response.body, symbolize_names: true)
    expect(json).to be_a Hash
    expect(json).to have_key(:data)
    expect(json[:data]).to have_key(:id)
    expect(json[:data]).to have_key(:type)
    expect(json[:data]).to have_key(:attributes)
    expect(json[:data][:attributes]).to have_key(:id)
    expect(json[:data][:attributes]).to have_key(:email)
    expect(json[:data][:attributes][:email]).to eq(user_params[:email])

    created_user = User.last

    expect(User.count).to eq(1)
    expect(created_user.email).to eq(user_params[:email])
    expect(created_user.password_digest).to be_a String
   end

   it "can give 400 status for bad user params" do
    user_params = ({
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "pppppasswordddddd"
     })
     headers = {"CONTENT_TYPE" => "application/json"}
     post "/api/v1/users", headers: headers, params: JSON.generate(user_params)
     
     expect(response.status).to eq(400)
     expect(User.count).to eq(0)
   end
end