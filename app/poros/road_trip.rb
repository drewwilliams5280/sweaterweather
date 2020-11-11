# frozen_string_literal: true

class RoadTrip
  attr_reader :start_city, :end_city, :travel_time, :weather_at_eta, :id

  def initialize(map_data, weather_data)
    @start_city = format_start_city(map_data[:route][:locations][0])
    @end_city = format_end_city(map_data[:route][:locations][1])
    @travel_time = format_travel_time(map_data[:route][:formattedTime])
    @weather_at_eta = format_weather_at_eta(map_data[:route][:formattedTime], weather_data)
    @id = nil
  end

  def format_start_city(location_info)
    "#{location_info[:adminArea5]}, #{location_info[:adminArea3]}"
  end

  def format_end_city(location_info)
    "#{location_info[:adminArea5]}, #{location_info[:adminArea3]}"
  end

  def format_travel_time(formatted_time)
    split_time = formatted_time.split(':').map(&:to_i)
    case split_time[0]
    when 0
      "#{split_time[1]} minutes"
    when 1
      "#{split_time[0]} hour, #{split_time[1]} minutes"
    else
      "#{split_time[0]} hours, #{split_time[1]} minutes"
    end
  end

  def format_weather_at_eta(travel_time, weather_data)
    split_time = travel_time.split(':').map(&:to_i)
    hours_until_arrival = split_time[0] + 1 if split_time[1] >= 30
    hours_until_arrival = split_time[0] if split_time[1] < 30
    weather = weather_data[:hourly][hours_until_arrival - 1] unless hours_until_arrival > 48
    if hours_until_arrival <= 48
      {
        temperature: weather[:temp],
        conditions: "#{weather[:weather][0][:main]} (#{weather[:weather][0][:description]})"
      }
    else
      'This information is only available for roadtrips shorter than 48 hours.'
    end
  end
end
