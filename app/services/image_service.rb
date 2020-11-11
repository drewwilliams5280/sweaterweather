# frozen_string_literal: true

class ImageService
  def self.get_image_details(latitude, longitude)
    image_params = {
      method: 'flickr.photos.search',
      lat: latitude,
      lon: longitude,
      per_page: '1',
      page: '1'
    }
    to_json('/services/rest/', image_params)
  end

  def self.to_json(url, params = {})
    response = conn.get(url) do |f|
      f.params = params
      f.params['api_key'] = ENV['IMAGE_API_KEY']
      f.params['format'] = 'json'
      f.params['nojsoncallback'] = '1'
      f.params['is_getty'] = 'yes'
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new('https://www.flickr.com')
  end
end
