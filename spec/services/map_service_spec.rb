require 'rails_helper'
RSpec.describe "MapService" do
  it 'can get location info' do
    location_info = MapService.get_location_info('dallas,tx')
    expect(location_info).to be_a Hash
    expect(location_info).to have_key(:results)
    expect(location_info[:results][0][:locations][0][:displayLatLng]).to have_key(:lat)
    expect(location_info[:results][0][:locations][0][:displayLatLng]).to have_key(:lng)
  end
end