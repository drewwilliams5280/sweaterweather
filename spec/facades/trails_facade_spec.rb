require 'rails_helper'
RSpec.describe 'Trails Facade' do
  it 'returns a trail object for given location' do
    trail = TrailFacade.get_trail_object('dallas,tx')
    expect(trail).to be_a Trail
    expect(trail.location).to eq('dallas,tx')
    expect(trail.forecast).to have_key(:summary)
    expect(trail.forecast).to have_key(:temperature)
    expect(trail.trails[0]).to have_key(:name)
    expect(trail.trails[0]).to have_key(:summary)
    expect(trail.trails[0]).to have_key(:difficulty)
    expect(trail.trails[0]).to have_key(:location)
    expect(trail.trails[0]).to have_key(:distance_to_trail)
  end
end