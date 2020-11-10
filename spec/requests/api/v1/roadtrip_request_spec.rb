require 'rails_helper'

RSpec.describe "Road trip" do
  it "can get and serialize road trip data" do
    json_response = File.read('spec/fixtures/denver_to_pueblo.json')

    stub_request(:get, "http://www.mapquestapi.com/directions/v2/route?from=Denver,CO&key=#{ENV['MAP_API_KEY']}&to=Pueblo,CO").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'User-Agent'=>'Faraday v1.1.0'
           }).
         to_return(status: 200, body: json_response, headers: {})

    json2 = File.read('spec/fixtures/pueblo_weather.json')

    stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV['WEATHER_API_KEY']}&lat=38.265427&lon=-104.610413&units=imperial").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'User-Agent'=>'Faraday v1.1.0'
           }).
         to_return(status: 200, body: json2, headers: {})

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

  it "can get correct messages for impossible trip" do
    json_response = File.read('spec/fixtures/impossible_roadtrip.json')

    stub_request(:get, "http://www.mapquestapi.com/directions/v2/route?from=New%20York,New%20York&key=#{ENV['MAP_API_KEY']}&to=London,UK").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'User-Agent'=>'Faraday v1.1.0'
           }).
         to_return(status: 200, body: json_response, headers: {})

    User.create(email: 'email@email.com', password: '123', password_confirmation: '123') do |user|
      user.auth_token = 'jgn983hy48thw9begh98h4539h4'
    end
    roadtrip = ({
      "origin": "New York,New York",
      "destination": "London,UK",
      "api_key": "jgn983hy48thw9begh98h4539h4"
    })
    headers = {"CONTENT_TYPE" => "application/json"}
    post "/api/v1/road_trip", headers: headers, params: JSON.generate(roadtrip)
    json = JSON.parse(response.body, symbolize_names: true)
    expect(json).to be_a Hash
    expect(json).to have_key(:data)
    expect(json[:data]).to have_key(:id)
    expect(json[:data]).to have_key(:type)
    expect(json[:data]).to have_key(:attributes)
    expect(json[:data][:attributes]).to have_key(:start_city)
    expect(json[:data][:attributes]).to have_key(:end_city)
    expect(json[:data][:attributes]).to have_key(:travel_time)
    expect(json[:data][:attributes][:travel_time]).to eq("impossible")
    expect(json[:data][:attributes]).to have_key(:weather_at_eta)
    expect(json[:data][:attributes][:weather_at_eta]).to eq("")
    expect(json[:data][:attributes][:start_city]).to eq("New York, New York")
    expect(json[:data][:attributes][:end_city]).to eq("London, UK")
  end

  it "can gives 400 error for wrong API key" do
    User.create(email: 'email@email.com', password: '123', password_confirmation: '123') do |user|
      user.auth_token = 'jgn983hy48thw9begh98h4539h4'
    end
    roadtrip = ({
      "origin": "New York,New York",
      "destination": "London,UK",
      "api_key": "jgn983hy48tdjkfjdkkdjfkladjsfhw9begh98h4539h4"
    })
    headers = {"CONTENT_TYPE" => "application/json"}
    post "/api/v1/road_trip", headers: headers, params: JSON.generate(roadtrip)
    json = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(401)
    expect(json).to have_key(:error)
    expect(json[:error]).to eq("API key incorrect.")
  end
end