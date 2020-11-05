class WeatherService

  def self.to_json(url, params = {})
    response = conn.get(url) do |f|
      f.params = params
    end
  end

  def self.conn
    Faraday.new('https://api.openweathermap.org')
  end

end