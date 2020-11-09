require 'rails_helper'
RSpec.describe "WeatherService" do
  it 'can get forecast for location' do
    json_response = File.read('spec/fixtures/weather_service_spec_line_3.json')
    stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV['WEATHER_API_KEY']}&lat=31.811&lon=-106.564&units=imperial").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'User-Agent'=>'Faraday v1.1.0'
           }).
         to_return(status: 200, body: json_response, headers: {})

    weather_info = WeatherService.get_forecast_for_location('31.811', '-106.564')
    expect(weather_info).to be_a Hash
    expect(weather_info).to have_key(:current)
    expect(weather_info[:current]).to have_key(:dt)
    expect(weather_info[:current]).to have_key(:sunrise)
    expect(weather_info[:current]).to have_key(:sunset)
    expect(weather_info[:current]).to have_key(:temp)
    expect(weather_info[:current]).to have_key(:feels_like)
    expect(weather_info).to have_key(:daily)
    expect(weather_info).to have_key(:hourly)
  end
end