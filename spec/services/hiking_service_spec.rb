require 'rails_helper'
RSpec.describe "HikingService" do
  it 'returns trails with latitude and longitude' do
    trails = HikingService.get_trails('31.811', '-106.564')
    expect(trails).to be_a Hash
    expect(trails).to have_key(:trails)
    trail = trails[:trails].first
    expect(trail).to have_key(:name)
    expect(trail).to have_key(:type)
    expect(trail).to have_key(:summary)
    expect(trail).to have_key(:stars)
    expect(trail).to have_key(:difficulty)
    expect(trail).to have_key(:length)
    expect(trail).to have_key(:url)
  end
end