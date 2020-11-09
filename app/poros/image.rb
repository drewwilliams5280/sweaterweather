class Image
  def initialize(location, data)
    @location = location
    @details = format_image_details(data)
    require 'pry'; binding.pry
  end

  def format_image_details(data)
    details = Hash.new
    details[:title] = data[:title]
    details[:location] = @location
    details[:image_url] = "https://live.staticflickr.com/#{data[:server]}/#{data[:id]}_#{data[:secret]}.jpg"
    details[:credit] = {
      source: 'flickr.com',
      owner_id: data[:owner],
      mandatory_disclaimer: "This product uses the Flickr API but is not endorsed or certified by SmugMug, Inc."
    }
    details
  end
end