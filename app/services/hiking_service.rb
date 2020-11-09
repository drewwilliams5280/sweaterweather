class HikingService
  def self.get_trails(latitude, longitude)
    to_json('/data/get-trails', { lat: latitude, lon: longitude })
  end
  
  def self.to_json(url, params = {})
    response = conn.get(url) do |f|
      f.params = params
      f.params[:key] = ENV['HIKING_API_KEY']
    end
    JSON.parse(response.body, symbolize_names: true)
  end
  
  def self.conn
    Faraday.new(url: "https://www.hikingproject.com")
  end
 end 