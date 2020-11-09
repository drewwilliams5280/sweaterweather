require 'rails_helper'
RSpec.describe "WeatherService" do
  it 'can get forecast for location' do
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