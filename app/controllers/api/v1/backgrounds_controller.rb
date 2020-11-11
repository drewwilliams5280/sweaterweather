# frozen_string_literal: true

module Api
  module V1
    # Creates background image endpoint for FE
    class BackgroundsController < ApplicationController
      def index
        image = ImageFacade.create_image_object(params[:location])
        render json: ImageSerializer.new(image)
      end
    end
  end
end
