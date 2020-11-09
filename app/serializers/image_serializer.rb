class ImageSerializer
  include FastJsonapi::ObjectSerializer

  attribute :image do |object|
    object.details
  end
end