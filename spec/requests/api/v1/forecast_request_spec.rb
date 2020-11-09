require 'rails_helper'

RSpec.describe "Trails path" do
  it "can get basic weather and trail info" do
    get '/api/v1/trails?location=denver,co'
    expect(response).to be_successful
    weather = JSON.parse(response.body, symbolize_names: true)
    expect(trail).to be_a Hash

    trail_data = trail[:data]
    expect(trail_data).to be_a Hash
    expect(trail_data).to have_key(:id)
    expect(trail_data).to have_key(:type)
    expect(trail_data).to have_key(:attributes)
    expect(trail_data[:attributes]).to have_key(:location)
    expect(trail_data[:attributes]).to have_key(:forecast)
    expect(trail_data[:attributes][:forecast]).to have_key(:summary)
    expect(trail_data[:attributes][:forecast]).to have_key(:temperature)
    expect(trail_data[:attributes]).to have_key(:trails)
    expect(trail_data[:attributes][:trails]).to have_key(:name)
    expect(trail_data[:attributes][:trails]).to have_key(:summary)
    expect(trail_data[:attributes][:trails]).to have_key(:difficulty)
    expect(trail_data[:attributes][:trails]).to have_key(:location)
    expect(trail_data[:attributes][:trails]).to have_key(:distance_to_trail)
  end
end