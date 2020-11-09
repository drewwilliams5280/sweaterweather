class Trail
  attr_reader :location, :forecast, :trails, :id
  def initialize(data)
    @location = data[:location]
    @forecast = format_forecast(data[:forecast])
    @trails = format_trails(data[:trails])
    @id = nil
  end

  def format_forecast(forecast_data)
    forecast = Hash.new
    forecast[:summary] = "#{forecast_data[:weather][0][:main]} (#{forecast_data[:weather][0][:description]})"
    forecast[:temperature] = "#{forecast_data[:temp]}"
    forecast
  end

  def format_trails(trails_hash)
    trails_hash[:trails].map do |single_trail_hash|
      single_trail_hash[:distance_to_trail] = MapService.get_distance(@location, single_trail_hash[:latitude], single_trail_hash[:longitude])
      single_trail_hash.slice!(:name, :summary, :difficulty, :location, :distance_to_trail)
      single_trail_hash
    end
  end
end