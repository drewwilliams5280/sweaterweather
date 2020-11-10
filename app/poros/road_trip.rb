class RoadTrip
  attr_reader :start_city, :end_city, :travel_time, :weather_at_eta
  def initialize(map_data, weather_data)
    @start_city = format_start_city(map_data[:route][:locations][0])
    @end_city = format_end_city(map_data[:route][:locations][1])
    @travel_time = format_travel_time(map_data[:route][:formattedTime])
    @weather_at_eta = format_weather_at_eta(map_data[:route][:formattedTime], weather_data)
  end

  def format_start_city(location_info)
    x = "#{location_info[:adminArea5]}, #{location_info[:adminArea3]}"
    require 'pry'; binding.pry
  end

end