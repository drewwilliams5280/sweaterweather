class Api::V1::TrailsController < ApplicationController
  def index
    trails = TrailsFacade.get_trails_objects(params[:location])
  end
end