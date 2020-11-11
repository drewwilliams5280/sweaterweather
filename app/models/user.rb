# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_secure_token :auth_token

  validates :email, uniqueness: true, presence: true
  validates :password, presence: true
end
