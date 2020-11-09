class TrailsFacade
  def self.get_trails_object(location)
    data = {
      location: location,
      forecast: get_forecast_for_location(location),
      trails: get_trails_for_location(location)
    }
    Trail.new(data)
  end
end