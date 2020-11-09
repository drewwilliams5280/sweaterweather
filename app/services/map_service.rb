class MapService
  def self.get_location_info(location)
    to_json('/geocoding/v1/address', {location: location})
  end

  def self.get_distance(starting_location, ending_latitude, ending_longitude)
    json = to_json('/directions/v2/route', {from: starting_location, to: "#{ending_latitude},#{ending_longitude}"})
    json[:route][:legs][0][:distance]
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