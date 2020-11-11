# frozen_string_literal: true

class RoadTripError
  attr_reader :start_city, :end_city, :travel_time, :weather_at_eta, :id

  def initialize(origin, destination)
    @start_city = format_origin(origin)
    @end_city = format_destination(destination)
    @travel_time = 'impossible'
    @weather_at_eta = ''
    @id = nil
  end

  def format_origin(origin)
    origin.gsub(',', ', ')
  end

  def format_destination(destination)
    destination.gsub(',', ', ')
  end
end
