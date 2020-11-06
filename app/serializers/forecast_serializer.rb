class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  
  attribute :current_weather do |object|
    object.current_weather
    object.current_weather[:dt]
  end
end