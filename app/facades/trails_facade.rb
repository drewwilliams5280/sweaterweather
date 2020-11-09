class TrailsFacade
  def self.get_trails_object(location)
    data = {
      location: location,
      forecast: get_forecast_for_location(location),
      trails: get_trails_for_location(location)
    }
    Trail.new(data)
  end

  def self.get_forecast_for_location(location)
    location_info_hash = MapService.get_location_info(location)
    latitude = location_info_hash[:results][0][:locations][0][:displayLatLng][:lat]
    longitude = location_info_hash[:results][0][:locations][0][:displayLatLng][:lng]
    WeatherService.get_forecast_for_location(latitude, longitude)
  end

  def self.get_trails_for_location(location)
    
  end
end