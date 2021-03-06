# frozen_string_literal: true

module Api
  module V1
    # Creates roadtrip endpoint for FE
    class RoadTripController < ApplicationController
      def create
        if User.exists?(auth_token: roadtrip_params[:api_key])
          roadtrip = RoadTripFacade.create_roadtrip_object(roadtrip_params[:origin], roadtrip_params[:destination])
          render json: RoadTripSerializer.new(roadtrip)
        else
          render json: { error: 'API key incorrect.' }, status: 401
        end
      end

      private

      def roadtrip_params
        JSON.parse(request.env['RAW_POST_DATA'], symbolize_names: true)
      end
    end
  end
end
