require 'rails_helper'

describe "Background API" do

  it "signs in an user" do
    user1 = User.create(email: "whatever@example.com",
                        password: "password",
                        api_key: 'faked-api-key')

    user_params = { email: "whatever@example.com",
                    password: "password"}
    post '/api/v1/sessions', params: user_params
    expect(response).to be_successful
    user = JSON.parse(response.body)
    expect(response.status).to eq(200)
    expect(user["data"]["attributes"]["email"]).to eq("whatever@example.com")
    expect(user["data"]["attributes"]["api_key"]).to eq('faked-api-key')
  end

  it "errors out if password is wrong" do
    user1 = User.create(email: "whatever@example.com",
                        password: "cheese",
                        api_key: 'faked-api-key')

    user_params = { email: "whatever@example.com",
                    password: "password"}
    post '/api/v1/sessions', params: user_params
    user = JSON.parse(response.body)
    expect(response.status).to eq(402)
    expect(user["error"]).to eq("Password does not match")
  end

  it "errors out if fields are blank" do
    user1 = User.create(email: "whatever@example.com",
                        password: "cheese",
                        api_key: 'faked-api-key')

    user_params = { email: "whatever@example.com"}
    post '/api/v1/sessions', params: user_params
    user = JSON.parse(response.body)
    expect(response.status).to eq(401)
    expect(user["error"]).to eq("One or more fields are blank")
  end

  it "errors out if password is wrong" do
    user_params = { email: "whatever@example.com",
                    password: "password"}
    post '/api/v1/sessions', params: user_params
    user = JSON.parse(response.body)
    expect(response.status).to eq(403)
    expect(user["error"]).to eq("User does not exist")
  end


end
