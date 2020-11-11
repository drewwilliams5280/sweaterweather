# frozen_string_literal: true

class RoadTripSerializer
  include FastJsonapi::ObjectSerializer
  set_type :roadtrip
  attributes :start_city, :end_city, :travel_time, :weather_at_eta
end
