require 'rails_helper'

RSpec.describe "Roadtrip Facade" do
  it 'can get roadtrip object' do

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
    trip = RoadTripFacade.create_roadtrip_object("Denver,CO", "Pueblo,CO")
    expect(trip).to be_a RoadTrip
  end
end