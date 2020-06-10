require 'rails_helper'

describe "Road Trip API" do

  it "sends a road trip back", :vcr do
    user1 = User.create(email: "whatever@example.com",
                        password: "password",
                        api_key: 'faked-api-key')
    road_trip_params = {origin: "Houston,TX",
                        destination: "Seattle,WA",
                        api_key: 'faked-api-key'}
    post '/api/v1/road_trip', params: road_trip_params
    expect(response).to be_successful
    road_trip = JSON.parse(response.body)
    expect(road_trip['data']['attributes']["origin"]).to eq("Houston,TX")
    expect(road_trip['data']['attributes']["destination"]).to eq("Seattle,WA")
    expect(road_trip['data']['attributes']["travel_time"]).to eq("1 day 11 hours")
    expect(road_trip['data']['attributes']["forecast"]["temperature"]).to eq("55.6")
    expect(road_trip['data']['attributes']["forecast"]["summary"]).to eq("overcast clouds")
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
