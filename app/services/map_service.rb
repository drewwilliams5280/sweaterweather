class MapService
  def self.get_location_info(location)
    to_json('/geocoding/v1/address', {location: location})
  end

  def self.to_json(url, params = {})
    response = conn.get(url) do |f|
      f.params = params
      f.params['key'] = ENV['MAP_API_KEY']
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new('http://www.mapquestapi.com')
  end
end