class ForecastFacade
  def self.get_forecast_for_location(location)
    location_info_hash = MapService.get_location_info(location)
    latitude = location_info_hash[:results][0][:displayLatLng][:lat]
    longitutde = location_info_hash[:results][0][:displayLatLng][:lng]
    forecast_info_hash = WeatherService.get_forcast_for_location(latitude, longitude)
    Forecast.new(forecast_info_hash)
  end
end