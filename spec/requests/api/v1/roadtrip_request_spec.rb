require 'rails_helper'

RSpec.describe "Road trip" do
  it "can get and serialize road trip data" do
    User.create(email: 'email@email.com', password: '123', password_confirmation: '123') do |user|
      user.auth_token = 'jgn983hy48thw9begh98h4539h4'
    end
    roadtrip = ({
      "origin": "Denver,CO",
      "destination": "Pueblo,CO",
      "api_key": "jgn983hy48thw9begh98h4539h4"
    })
    headers = {"CONTENT_TYPE" => "application/json"}
    post "/api/v1/road_trip", headers: headers, params: JSON.generate(roadtrip)
    json = JSON.parse(response.body, symbolize_names: true)
    require 'pry'; binding.pry
    expect(json).to be_a Hash
    expect(json).to have_key(:data)
    expect(json[:data]).to have_key(:id)
    expect(json[:data]).to have_key(:type)
    expect(json[:data]).to have_key(:attributes)
    expect(json[:data][:attributes]).to have_key(:start_city)
    expect(json[:data][:attributes]).to have_key(:end_city)
    expect(json[:data][:attributes]).to have_key(:travel_time)
    expect(json[:data][:attributes]).to have_key(:weather_at_eta)
    expect(json[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
    expect(json[:data][:attributes][:weather_at_eta]).to have_key(:conditions)
    expect(json[:data][:attributes][:start_city]).to eq("Denver, CO")
    expect(json[:data][:attributes][:end_city]).to eq("Pueblo, CO")
  end
end