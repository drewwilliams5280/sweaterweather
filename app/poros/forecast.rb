# frozen_string_literal: true

class Forecast
  attr_reader :current_weather, :daily_weather, :hourly_weather, :id

  def initialize(data)
    @current_weather = convert_current_data(data[:current])
    @daily_weather = convert_daily_data(data[:daily])
    @hourly_weather = convert_hourly_data(data[:hourly][0..7])
    @id = nil
  end

  def convert_current_data(original_data)
    original_data[:datetime] = Time.at(original_data[:dt]).to_datetime.strftime('%FT%T%:z')
    original_data[:sunrise] = Time.at(original_data[:sunrise]).to_datetime.iso8601
    original_data[:sunset] = Time.at(original_data[:sunset]).to_datetime.iso8601
    original_data[:conditions] = original_data[:weather][0][:description]
    original_data[:icon] = original_data[:weather][0][:icon]
    original_data.slice!(:datetime, :sunrise, :sunset, :temp, :feels_like, :humidity, :uvi, :visibility, :conditions, :icon)
    original_data
  end

  def convert_daily_data(original_data)
    original_data.map do |single_data_hash|
      single_data_hash[:date] = Time.at(single_data_hash[:dt]).to_datetime.strftime('%F')
      single_data_hash[:sunrise] = Time.at(single_data_hash[:sunrise]).to_datetime.iso8601
      single_data_hash[:sunset] = Time.at(single_data_hash[:sunset]).to_datetime.iso8601
      single_data_hash[:max_temp] = single_data_hash[:temp][:max]
      single_data_hash[:min_temp] = single_data_hash[:temp][:min]
      single_data_hash[:conditions] = single_data_hash[:weather][0][:description]
      single_data_hash[:icon] = single_data_hash[:weather][0][:icon]
      single_data_hash.slice!(:date, :sunrise, :sunset, :max_temp, :min_temp, :conditions, :icon)
      single_data_hash
    end
  end

  def convert_hourly_data(original_data)
    original_data.map do |single_data_hash|
      single_data_hash[:time] = Time.at(single_data_hash[:dt]).to_datetime.strftime('%T')
      single_data_hash[:wind_speed] = "#{single_data_hash[:wind_speed]} mph"
      single_data_hash[:wind_directions] = convert_wind_degrees_to_direction(single_data_hash[:wind_deg])
      single_data_hash[:conditions] = single_data_hash[:weather][0][:description]
      single_data_hash[:icon] = single_data_hash[:weather][0][:icon]
      single_data_hash.slice!(:time, :wind_speed, :wind_directions, :conditions, :icon)
      single_data_hash
    end
  end

  def convert_wind_degrees_to_direction(degrees)
    value = (degrees / 22.5) + 0.5
    array = %w[N NNE NE ENE E ESE SE SSE S SSW SW WSW W WNW NW NNW]
    array[value.truncate - 1]
  end
end
