class UserSerializer
  include FastJsonapi::ObjectSerializer
  set_type :users

  attributes :email

  attribute :api_key do |obj|
    obj.auth_token
  end
end