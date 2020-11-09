class Api::V1::TrailsController < ApplicationController
  def index
    trail = TrailsFacade.get_trails_object(params[:location])
    render json: TrailSerializer.new(trail)
  end
end