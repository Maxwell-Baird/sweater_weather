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
    expect(road_trip['data']['attributes']["destination"]).to eq("Pueblo,CO")
    expect(road_trip['data']['attributes']["travel_time"]).to eq("1 hour 48 mins")
    expect(road_trip['data']['attributes']["forecast"]["temperature"]).to be_a(Float)
    expect(road_trip['data']['attributes']["forecast"]["summary"]).to be_a(String)
  end

  it 'errors out if api key is wrong' do
    user1 = User.create(email: "whatever@example.com",
                        password: "password",
                        api_key: 'true-api-key')
    road_trip_params = {origin: "Denver,CO",
                        destination: "Pueblo,CO",
                        api_key: 'faked-api-key'}
    post '/api/v1/road_trip', params: road_trip_params
    road_trip = JSON.parse(response.body)
    expect(response.status).to eq(401)
    expect(road_trip["error"]).to eq("Api key is wrong")
  end

  it 'errors out if a field is blank' do
    user1 = User.create(email: "whatever@example.com",
                        password: "password",
                        api_key: 'true-api-key')
    road_trip_params = {origin: "Denver,CO",
                        api_key: 'true-api-key'}
    post '/api/v1/road_trip', params: road_trip_params
    road_trip = JSON.parse(response.body)
    expect(response.status).to eq(403)
    expect(road_trip["error"]).to eq("One or more fields are missing")
  end

  it 'errors out if a location is wrong' do
    user1 = User.create(email: "whatever@example.com",
                        password: "password",
                        api_key: 'true-api-key')
    road_trip_params = {origin: "Denver,Colorado",
                        destination: "Pueblo,CO",
                        api_key: 'true-api-key'}
    post '/api/v1/road_trip', params: road_trip_params
    road_trip = JSON.parse(response.body)
    expect(response.status).to eq(402)
    expect(road_trip["error"]).to eq("One or more locations are in an incorrect format")
  end
end
