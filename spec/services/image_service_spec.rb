require 'rails_helper'
RSpec.describe "ImageService" do
  it 'can get photo info' do
    json_response = File.read('spec/fixtures/denver_flickr_response.json')
    stub_request(:get, "https://www.flickr.com/services/rest/?api_key=#{ENV['IMAGE_API_KEY']}&format=json&is_getty=yes&lat=39.738453&lon=-104.984853&method=flickr.photos.search&nojsoncallback=1&page=1&per_page=1").
    with(
      headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'=>'Faraday v1.1.0'
      }).
    to_return(status: 200, body: json_response, headers: {})
    photo_info = ImageService.get_image_details('39.738453', '-104.984853')
    expect(photo_info).to be_a Hash
    expect(photo_info).to have_key(:photos)
    expect(photo_info[:photos]).to have_key(:photo)
    expect(photo_info[:photos][:photo]).to be_a Array
    expect(photo_info[:photos][:photo][0]).to be_a Hash
    expect(photo_info[:photos][:photo][0]).to have_key(:id)
    expect(photo_info[:photos][:photo][0]).to have_key(:owner)
    expect(photo_info[:photos][:photo][0]).to have_key(:secret)
    expect(photo_info[:photos][:photo][0]).to have_key(:server)
    expect(photo_info[:photos][:photo][0]).to have_key(:title)
  end
end