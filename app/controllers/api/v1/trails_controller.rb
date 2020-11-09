class Api::V1::TrailsController < ApplicationController
  def index
    trails = TrailsFacade.get_trails_object(params[:location])
  end
end