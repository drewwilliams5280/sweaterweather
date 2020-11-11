require 'rails_helper'

describe "Roadtrip" do 
  it "can exist" do 
    map_data = File.read('spec/fixtures/denver_to_pueblo.json')
    json_map_data = JSON.parse(map_data, symbolize_names: true)
    weather_data = File.read('spec/fixtures/pueblo_weather.json')
    json_weather_data = JSON.parse(weather_data, symbolize_names: true)
    trip = RoadTrip.new(json_map_data, json_weather_data)
    expect(trip).to be_a RoadTrip 
    expect(trip.start_city).to eq("Denver, CO")
    expect(trip.end_city).to eq("Pueblo, CO")
    expect(trip.travel_time).to eq("1 hour, 43 minutes")
    expect(trip.weather_at_eta).to be_a Hash
    expect(trip.weather_at_eta).to have_key(:temperature)
    expect(trip.weather_at_eta).to have_key(:conditions)
  end

  it "can format all possible travel times" do 
    map_data = File.read('spec/fixtures/denver_to_pueblo.json')
    json_map_data = JSON.parse(map_data, symbolize_names: true)
    weather_data = File.read('spec/fixtures/pueblo_weather.json')
    json_weather_data = JSON.parse(weather_data, symbolize_names: true)
    trip = RoadTrip.new(json_map_data, json_weather_data)
    time1 = trip.format_travel_time("00:33:33")
    time2 = trip.format_travel_time("01:33:33")
    time3 = trip.format_travel_time("02:33:33")
    time4 = trip.format_travel_time("14:33:33")
    time5 = trip.format_travel_time("33:33:33")
    expect(time1).to eq("33 minutes")
    expect(time2).to eq("1 hour, 33 minutes")
    expect(time3).to eq("2 hours, 33 minutes")
    expect(time4).to eq("14 hours, 33 minutes")
    expect(time5).to eq("33 hours, 33 minutes")
  end

  it "can format weather at eta" do 
    map_data = File.read('spec/fixtures/denver_to_pueblo.json')
    json_map_data = JSON.parse(map_data, symbolize_names: true)
    weather_data = File.read('spec/fixtures/pueblo_weather.json')
    json_weather_data = JSON.parse(weather_data, symbolize_names: true)
    trip = RoadTrip.new(json_map_data, json_weather_data)
    weather = trip.format_weather_at_eta("64:32:11", weather_data)
    expect(weather).to eq("This information is only available for roadtrips shorter than 48 hours.")
  end
end