# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'MapService' do
  it 'can get location info' do
    json_response = File.read('spec/fixtures/dallas_map_data.json')
    stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['MAP_API_KEY']}&location=dallas,tx").to_return(status: 200, body: json_response)

    location_info = MapService.get_location_info('dallas,tx')
    expect(location_info).to be_a Hash
    expect(location_info).to have_key(:results)
    expect(location_info[:results][0][:locations][0][:displayLatLng]).to have_key(:lat)
    expect(location_info[:results][0][:locations][0][:displayLatLng]).to have_key(:lng)
  end
end
