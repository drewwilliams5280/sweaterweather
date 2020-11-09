require 'rails_helper'

RSpec.describe "Background image" do
  it "can get an image for a city" do
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


    get '/api/v1/backgrounds?location=denver,co'
    expect(response).to be_successful
    image = JSON.parse(response.body, symbolize_names: true)
    expect(image).to be_a Hash

    image_results = image[:data]
    expect(image_results).to be_a Hash
    expect(image_results).to have_key(:id)
    expect(image_results).to have_key(:type)
    expect(image_results).to have_key(:attributes)
    expect(image_results[:attributes]).to have_key(:image)
    expect(image_results[:attributes][:image]).to have_key(:location)
    expect(image_results[:attributes][:image]).to have_key(:image_url)
    expect(image_results[:attributes][:image]).to have_key(:credit)
    expect(image_results[:attributes][:image][:credit]).to have_key(:source)
  end
end