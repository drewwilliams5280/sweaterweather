# frozen_string_literal: true

module Api
  module V1
    # Creates sessions endpoint for FE
    class SessionsController < ApplicationController
      def create
        user = User.find_by(email: user_params[:email])
        if user.authenticate(user_params[:password])
          render json: UserSerializer.new(user)
        else
          render json: { error: 'Login credentials incorrect.' }, status: 400
        end
      end

      private

      def user_params
        JSON.parse(request.env['RAW_POST_DATA'], symbolize_names: true)
      end
    end
  end
end
