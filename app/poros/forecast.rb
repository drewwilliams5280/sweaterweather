class Forecast
  def initialize(data)
    @current_weather = data[:current]
    @daily_weather = data[:daily]
    @hourly_weather = data[:hourly]
  end
end