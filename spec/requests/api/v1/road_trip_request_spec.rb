require 'rails_helper'

describe "Background API" do
  it "sends a url back" do
    user1 = User.create(email: "whatever@example.com",
                        password: "password",
                        api_key: 'faked-api-key')
    road_trip_params = {origin: "Denver,CO",
                        destination: "Pueblo,CO",
                        api_key: 'faked-api-key'}
    post '/api/v1/road_trip', params: road_trip_params
    expect(response).to be_successful
    road_trip = JSON.parse(response.body)
    expect(road_trip['data']['attributes']["origin"]).to eq("Denver,CO")
    expect(road_trip['data']['attributes']["destination"]).to eq("Denver,CO")
    expect(road_trip['data']['attributes']["travel_time"]).to eq("2 Hours")
    expect(road_trip['data']['attributes']["temperature"]).to be_a(Float)
    expect(road_trip['data']['attributes']["weather"]).to be_a(String)
  end
end
