require 'rails_helper'

describe "Image" do 
  it "can exist" do 
    data = File.read('spec/fixtures/denver_flickr_response.json')
    json_data = JSON.parse(data, symbolize_names: true)
    image = Image.new('denver,co', json_data[:photos][:photo][0])
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