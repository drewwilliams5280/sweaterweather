class WeatherService
  def self.get_forecast_for_location(latitude, longitude)
    to_json('/data/2.5/onecall', { lat: latitude, lon: longitude })
  end

  def self.to_json(url, params = {})
    response = conn.get(url) do |f|
      f.params = params
      f.params['appid'] = ENV['WEATHER_API_KEY']
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new('https://api.openweathermap.org')
  end
end