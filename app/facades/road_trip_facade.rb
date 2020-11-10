class RoadTripFacade

  def self.create_roadtrip_object(origin, destination)
    map_data = MapService.get_directions(origin, destination)
    destination_latitude = map_data[:route][:locations][1][:displayLatLng][:lat]
    destination_longitude = map_data[:route][:locations][1][:displayLatLng][:lng]
    weather_data = WeatherService.get_forecast_for_location(destination_latitude, destination_longitude)
    RoadTrip.new(map_data, weather_data)
    # split_travel_time = map_data[:route][:formattedTime].split(':').map { |num| num.to_i }
    # eta = Time.now + split_travel_time[0].hours + split_travel_time[1].minutes
  end

end