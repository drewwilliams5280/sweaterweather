class ImageFacade
  def self.create_image_object(location)
    location_info_hash = MapService.get_location_info(location)
    latitude = location_info_hash[:results][0][:locations][0][:displayLatLng][:lat]
    longitude = location_info_hash[:results][0][:locations][0][:displayLatLng][:lng]
    image_info = ImageService.get_image_details(latitude, longitude)
    Image.new(location, image_info[:photos][:photo][0])
  end
end