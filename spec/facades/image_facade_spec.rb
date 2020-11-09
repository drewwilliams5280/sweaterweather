require 'rails_helper'

RSpec.describe 'Image Facade' do
  it 'can get image object for a location' do
    json_response = File.read('spec/fixtures/denver_map_request.json')
    stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['MAP_API_KEY']}&location=denver,co").
    with(
      headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'=>'Faraday v1.1.0'
      }).
    to_return(status: 200, body: json_response, headers: {})
      
    json_response2 = File.read('spec/fixtures/denver_flickr_response.json')
    stub_request(:get, "https://www.flickr.com/services/rest/?api_key=#{ENV['IMAGE_API_KEY']}&format=json&is_getty=yes&lat=39.738453&lon=-104.984853&method=flickr.photos.search&nojsoncallback=1&page=1&per_page=1").
         with(
           headers: {
           'Accept'=>'*/*',
           'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
           'User-Agent'=>'Faraday v1.1.0'
           }).
         to_return(status: 200, body: json_response2, headers: {})

    image = ImageFacade.create_image_object('denver,co')
    expect(image).to be_a Image
    expect(image.details).to be_a Hash
    expect(image.location).to eq('denver,co')
    expect(image.details).to have_key(:title)
    expect(image.details).to have_key(:location)
    expect(image.details).to have_key(:image_url)
    expect(image.details).to have_key(:credit)
    expect(image.details[:credit]).to have_key(:source)
    expect(image.details[:credit]).to have_key(:owner_id)
    expect(image.details[:credit]).to have_key(:mandatory_disclaimer)
  end 
end