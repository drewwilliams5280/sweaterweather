# frozen_string_literal: true

module Api
  module V1
    # Creates users endpoint for FE
    class UsersController < ApplicationController
      def create
        user = User.new(user_params)
        if user.save
          render json: UserSerializer.new(user), status: 201
        else
          render json: { error: user.errors.full_messages }, status: 400
        end
      end

      private

      def user_params
        JSON.parse(request.env['RAW_POST_DATA'], symbolize_names: true)
      end
    end
  end
end
