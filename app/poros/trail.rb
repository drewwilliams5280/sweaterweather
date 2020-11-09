class Trail
  def initialize(data)
    @location = data[:location]
    @forecast = format_forecast(data[:forecast])
    @trails = format_trails(data[:trails])
  end

  def format_forecast(forecast_data)
    forecast = Hash.new
    forecast[:summary] = "#{forecast_data[:weather][0][:main]} (#{forecast_data[:weather][0][:description]})"
    forecast[:temperature] = "#{forecast_data[:temp]}"
    forecast
  end

  def format_trails(trails)
    require 'pry'; binding.pry
  end
end