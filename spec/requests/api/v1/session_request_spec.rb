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


end
