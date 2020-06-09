require 'rails_helper'

describe "Foodie API" do
  it "sends a foodie object back" do
    get '/api/v1/foodie?start=denver,co&end=pueblo,co&search=italian'
    expect(response).to be_successful
    foodie = JSON.parse(response.body)

    expect(foodie["data"]["attributes"]["end_location"]).to eq("pueblo,co")
    expect(foodie["data"]["attributes"]["travel_time"]).to eq("1 hour 48 mins")
    expect(foodie["data"]["attributes"]["forecast"]["summary"]).to eq("clear sky")
    expect(foodie["data"]["attributes"]["forecast"]["temperature"]).to be_a(Float)
    expect(foodie["data"]["attributes"]["restaurant"]["name"]).to eq("Angelo's Pizza Parlor")
    expect(foodie["data"]["attributes"]["restaurant"]["address"]).to eq("105 E Riverwalk, Pueblo 81003")
  end
end
