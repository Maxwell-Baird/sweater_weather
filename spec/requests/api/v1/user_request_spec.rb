require 'rails_helper'

describe "Background API" do
  it "creates an user" do
    user_params = { email: "whatever@example.com",
                    password: "password",
                    password_confirmation: "password"}
    post '/api/v1/users', params: {user: user_params}
    expect(response).to be_successful
    user = JSON.parse(response.body)

    expect(user["status"]).to eq("201")
    expect(user["data"]["attributes"]["email"]).to eq("whatever@example.com")
    expect(user["data"]["attributes"]["api_key"]).to be_a(String)
  end
end
