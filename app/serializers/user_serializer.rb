# frozen_string_literal: true

class UserSerializer
  include FastJsonapi::ObjectSerializer
  set_type :users

  attributes :email

  attribute :api_key, &:auth_token
end
