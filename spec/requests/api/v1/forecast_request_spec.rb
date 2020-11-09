require 'rails_helper'

RSpec.describe "Forecast" do
  it "can get weather for a city" do
    json_response = File.read('spec/fixtures/denver_map_request.json')
    stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['MAP_API_KEY']}&location=denver,co").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'User-Agent'=>'Faraday v1.1.0'
           }).
         to_return(status: 200, body: json_response, headers: {})

    json2 = File.read('spec/fixtures/denver_weather_request.json')
    stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV['WEATHER_API_KEY']}&lat=39.738453&lon=-104.984853&units=imperial").
    with(
      headers: {
     'Accept'=>'*/*',
     'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
     'User-Agent'=>'Faraday v1.1.0'
      }).
    to_return(status: 200, body: json2, headers: {})

    get '/api/v1/forecast?location=denver,co'
    expect(response).to be_successful
    weather = JSON.parse(response.body, symbolize_names: true)
    expect(weather).to be_a Hash
    
    weather_results = weather[:data]
    expect(weather_results).to be_a Hash
    expect(weather_results).to have_key(:id)
    expect(weather_results).to have_key(:type)
    expect(weather_results).to have_key(:attributes)
    expect(weather_results[:attributes]).to have_key(:current_weather)
    expect(weather_results[:attributes]).to have_key(:daily_weather)
    expect(weather_results[:attributes]).to have_key(:hourly_weather)
  end
end