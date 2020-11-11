# frozen_string_literal: true

class ImageSerializer
  include FastJsonapi::ObjectSerializer

  attribute :image, &:details
end
