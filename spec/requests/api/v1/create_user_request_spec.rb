require 'rails_helper'

describe "Users API" do
  it "can register/create a user" do
     user_params = ({
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
     })
     headers = {"CONTENT_TYPE" => "application/json"}
     post "/api/v1/users", headers: headers, params: JSON.generate(user_params)
     created_user = User.last
     require 'pry'; binding.pry
   end
end