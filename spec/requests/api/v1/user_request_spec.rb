require 'rails_helper'

describe "Background API" do
  it "creates an user" do
    user1 = User.create(email: "test@example.com", password: "password")

    user_params = { email: "whatever@example.com",
                    password: "password",
                    password_confirmation: "password"}
    post '/api/v1/users', params: user_params
    expect(response).to be_successful
    user = JSON.parse(response.body)
    expect(response.status).to eq(201)
    expect(user["data"]["attributes"]["email"]).to eq("whatever@example.com")
    expect(user["data"]["attributes"]["api_key"].length).to eq(22)
  end

  it "errors out if passwords do not match" do
    user_params = { email: "whatever@example.com",
                    password: "password",
                    password_confirmation: "cheese"}
    post '/api/v1/users', params: user_params
    user = JSON.parse(response.body)
    expect(response.status).to eq(402)
    expect(user["error"]).to eq("Passwords do not match")
  end

  it "errors out if params are blank do not match" do
    user_params = { password: "password",
                    password_confirmation: "password"}
    post '/api/v1/users', params: user_params
    user = JSON.parse(response.body)

    expect(response.status).to eq(401)
    expect(user["error"]).to eq("One or more fields are blank")
  end

  it "errors out if email is in use" do
    user1 = User.create(email: "whatever@example.com", password: "password")
    user_params = { email: "whatever@example.com",
                    password: "password",
                    password_confirmation: "password"}
    post '/api/v1/users', params: user_params
    user = JSON.parse(response.body)
    expect(response.status).to eq(403)
    expect(user["error"]).to eq("Email already in use")
  end
end
