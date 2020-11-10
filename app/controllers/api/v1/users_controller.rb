require 'securerandom'

class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params) do |user|
      user.api_key = SecureRandom.urlsafe_base64
    end
    if user.save
      render json: UserSerializer.new(user), status: 201
    else
      render json: user.errors.full_messages, status: 400
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end