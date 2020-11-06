require 'rails_helper'

RSpec.describe "Forecast" do
  it "can get weather for a city" do
    get '/api/v1/forecast?location=denver,co'
    expect(response).to be_successful
    weather = JSON.parse(response.body, symbolize_names: true)
    expect(weather).to be_a Hash
    
    weather_results = weather[:data]
    require 'pry'; binding.pry
    expect(weather_results).to be_a Hash
    expect(weather_results).to have_key(:id)
    expect(weather_results).to have_key(:type)
    expect(weather_results).to have_key(:attributes)
    expect(weather_results[:attributes]).to have_key(:current_weather)
  end
end