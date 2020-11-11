# frozen_string_literal: true

module Api
  module V1
    # Creates forecast endpoint for FE
    class ForecastController < ApplicationController
      def index
        forecast = ForecastFacade.get_forecast_for_location(params[:location])
        render json: ForecastSerializer.new(forecast)
      end
    end
  end
end
