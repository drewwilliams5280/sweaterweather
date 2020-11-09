require 'rails_helper'
RSpec.describe "MapService" do
  it 'can get location info' do
    location_info = MapService.get_location_info('dallas,tx')
    expect(location_info).to be_a Hash
    expect(location_info).to have_key(:results)
    expect(location_info[:results][0][:locations][0][:displayLatLng]).to have_key(:lat)
    expect(location_info[:results][0][:locations][0][:displayLatLng]).to have_key(:lng)
  end

  it "can get distance to location" do
    distance = MapService.get_distance('dallas,tx', '31.811', '-106.564')
    expect(distance).to be_a Float
    expect(distance > 600).to eq(true)
    expect(distance < 600).to eq(false)
    expect(distance < 700).to eq(true)
    expect(distance > 700).to eq(false)
  end
end