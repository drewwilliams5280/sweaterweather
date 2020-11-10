class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :email

  attribute :api_key do |obj|
    obj.auth_token
  end
end