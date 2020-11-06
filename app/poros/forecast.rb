class Forecast
  attr_reader :current_weather, :daily_weather, :hourly_weather, :id
  def initialize(data)
    @current_weather = convert_current_data(data[:current])
    @daily_weather = convert_daily_data(data[:daily])
    @hourly_weather = convert_hourly_data(data[:hourly])
    @id = nil
  end

  def convert_current_data(original_data)
    original_data[:dt] = Time.at(original_data[:dt]).to_datetime.iso8601
    original_data[:sunrise] = Time.at(original_data[:sunrise]).to_datetime.iso8601
    original_data[:sunset] = Time.at(original_data[:sunset]).to_datetime.iso8601
    original_data[:conditions] = original_data[:weather][0][:description]
    original_data[:icon] = original_data[:weather][0][:icon]
    original_data.slice!(:dt, :sunrise, :sunset, :temp, :feels_like, :humidity, :uvi, :visibility, :conditions, :icon)
    original_data
  end

  def convert_daily_data(original_data)
    original_data.map do |single_data_hash|
      single_data_hash[:dt] = Time.at(single_data_hash[:dt]).to_datetime.iso8601
      single_data_hash[:sunrise] = Time.at(single_data_hash[:sunrise]).to_datetime.iso8601
      single_data_hash[:sunset] = Time.at(single_data_hash[:sunset]).to_datetime.iso8601
      single_data_hash[:max_temp] = single_data_hash[:temp][:max]
      single_data_hash[:min_temp] = single_data_hash[:temp][:min]
      single_data_hash[:conditions] = single_data_hash[:weather][0][:description]
      single_data_hash[:icon] = single_data_hash[:weather][0][:icon]
      single_data_hash.slice!(:dt, :sunrise, :sunset, :max_temp, :min_temp, :conditions, :icon)
      single_data_hash
    end
    require 'pry'; binding.pry
  end
end