require 'rails_helper'

describe "Weather API" do
  it "sends a data about the current weather" do
    get '/api/v1/forecast?location=denver,co'

    expect(response).to be_successful

    weather = JSON.parse(response.body)
    expect(weather['data'].count).to eq(3)
  end
end
