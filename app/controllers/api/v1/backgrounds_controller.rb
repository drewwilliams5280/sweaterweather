class Api::V1::BackgroundsController < ApplicationController
  def index
    image = ImageFacade.create_image_object(params[:location])
  end
end