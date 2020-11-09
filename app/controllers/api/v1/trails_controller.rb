class Api::V1::TrailsController < ApplicationController
  def index
    trail = TrailFacade.get_trail_object(params[:location])
    render json: TrailSerializer.new(trail)
  end
end