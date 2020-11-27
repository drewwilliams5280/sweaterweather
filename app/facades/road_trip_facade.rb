# frozen_string_literal: true

class RoadTripFacade
  def self.create_roadtrip_object(origin, destination)
    map_data = MapService.get_directions(origin, destination)
    if map_data[:info][:statuscode].between?(400, 499)
      RoadTripError.new(origin, destination)
    else
      destination_latitude = map_data[:route][:locations][1][:displayLatLng][:lat]
      destination_longitude = map_data[:route][:locations][1][:displayLatLng][:lng]
      weather_data = WeatherService.get_forecast_for_location(destination_latitude, destination_longitude)
      RoadTrip.new(map_data, weather_data)
    end
  end
end