# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'Forecast Facade' do
  it 'can get forecast object for a location' do
    json_response = json_response = File.read('spec/fixtures/dallas_map_data.json')
    stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['MAP_API_KEY']}&location=dallas,tx")
      .with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent' => 'Faraday v1.1.0'
        }
      )
      .to_return(status: 200, body: json_response, headers: {})

    json2 = json_response = File.read('spec/fixtures/forecast_facade_spec_line_3.json')
    stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV['WEATHER_API_KEY']}&lat=32.777977&lon=-96.796215&units=imperial")
      .with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent' => 'Faraday v1.1.0'
        }
      )
      .to_return(status: 200, body: json2, headers: {})

    forecast = ForecastFacade.get_forecast_for_location('dallas,tx')
    expect(forecast).to be_a Forecast
    expect(forecast.current_weather).to be_a Hash
    expect(forecast.current_weather).to have_key(:datetime)
    expect(forecast.current_weather).to have_key(:sunrise)
    expect(forecast.current_weather).to have_key(:sunset)
    expect(forecast.current_weather).to have_key(:temp)
    expect(forecast.current_weather).to have_key(:feels_like)
    expect(forecast.current_weather).to have_key(:humidity)
    expect(forecast.current_weather).to have_key(:uvi)
    expect(forecast.current_weather).to have_key(:visibility)
    expect(forecast.current_weather).to have_key(:conditions)
    expect(forecast.current_weather).to have_key(:icon)
    expect(forecast.daily_weather).to be_a Array
    expect(forecast.daily_weather[0]).to be_a Hash
    expect(forecast.daily_weather[0]).to have_key(:date)
    expect(forecast.daily_weather[0]).to have_key(:sunrise)
    expect(forecast.daily_weather[0]).to have_key(:sunset)
    expect(forecast.daily_weather[0]).to have_key(:max_temp)
    expect(forecast.daily_weather[0]).to have_key(:min_temp)
    expect(forecast.daily_weather[0]).to have_key(:conditions)
    expect(forecast.daily_weather[0]).to have_key(:icon)
    expect(forecast.hourly_weather).to be_a Array
    expect(forecast.hourly_weather[0]).to be_a Hash
    expect(forecast.hourly_weather[0]).to have_key(:time)
    expect(forecast.hourly_weather[0]).to have_key(:wind_speed)
    expect(forecast.hourly_weather[0]).to have_key(:wind_directions)
    expect(forecast.hourly_weather[0]).to have_key(:conditions)
    expect(forecast.hourly_weather[0]).to have_key(:icon)
  end
end
