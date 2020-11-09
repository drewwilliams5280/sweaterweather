class ForecastFacade
  def self.get_forecast_for_location(location)
    location_info_hash = MapService.get_location_info(location)
    latitude = location_info_hash[:results][0][:locations][0][:displayLatLng][:lat]
    longitude = location_info_hash[:results][0][:locations][0][:displayLatLng][:lng]
    forecast_info_hash = WeatherService.get_forecast_for_location(latitude, longitude)
    Forecast.new(forecast_info_hash)
  end
end