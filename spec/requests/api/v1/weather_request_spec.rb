require 'rails_helper'

describe "Weather API" do
  it "sends a data about the upcoming week", :vcr do
    get '/api/v1/forecast?location=denver,co'

    expect(response).to be_successful

    weather = JSON.parse(response.body)

    expect(weather['data']["attributes"]['week'].count).to eq(6)
    expect(weather['data']["attributes"]['week'][0]['weather']).to eq("Clear")
    expect(weather['data']["attributes"]['week'][0]['icon']).to eq("01d")
    expect(weather['data']["attributes"]['week'][0]['day']).to eq("Wednesday")
    expect(weather['data']["attributes"]['week'][0]['high']).to eq("78.1")
    expect(weather['data']["attributes"]['week'][0]['low']).to eq("56.39")
    expect(weather['data']["attributes"]['week'][0]['precipitation']).to eq('0.0')
  end

  it "sends a data about the upcoming hours", :vcr do
    get '/api/v1/forecast?location=denver,co'

    expect(response).to be_successful

    weather = JSON.parse(response.body)

    expect(weather['data']["attributes"]['hourly'].count).to eq(8)
    expect(weather['data']["attributes"]['hourly'][0]['weather']).to eq("Clear")
    expect(weather['data']["attributes"]['hourly'][0]['icon']).to eq("01d")
    expect(weather['data']["attributes"]['hourly'][0]['hour']).to eq("08:00 PM")
    expect(weather['data']["attributes"]['hourly'][0]['tempature']).to eq("60.15")
  end

  it "sends a data about the details", :vcr do
    get '/api/v1/forecast?location=denver,co'

    expect(response).to be_successful

    weather = JSON.parse(response.body)
    expect(weather['data']["attributes"]['details']['weather']).to eq("Clear")
    expect(weather['data']["attributes"]['details']['icon']).to eq("01d")
    expect(weather['data']["attributes"]['details']['sun_rise']).to eq("05:31 AM")
    expect(weather['data']["attributes"]['details']['sun_set']).to eq("08:27 PM")
    expect(weather['data']["attributes"]['details']['feels_like']).to eq("54.23")
    expect(weather['data']["attributes"]['details']['uv']).to eq("11.27")
    expect(weather['data']["attributes"]['details']['humidity']).to eq('28')
  end

  it "sends a data about the current weather", :vcr do
    get '/api/v1/forecast?location=denver,co'

    expect(response).to be_successful

    weather = JSON.parse(response.body)

    expect(weather['data']["attributes"]['current']['weather']).to eq("Clear")
    expect(weather['data']["attributes"]['current']['icon']).to eq("01d")
    expect(weather['data']["attributes"]['current']['time']).to eq("08:20 PM, June  9")
    expect(weather['data']["attributes"]['current']['high']).to eq("61.14")
    expect(weather['data']["attributes"]['current']['low']).to eq("60.17")
    expect(weather['data']["attributes"]['current']['tempature']).to eq("60.17")

  end

  it "errors out when field is blank" do
    get '/api/v1/forecast?'
    expect(response.status).to eq(401)
    error = JSON.parse(response.body)
    expect(error["error"]).to eq("One or more fields are blank")
  end

  it "errors out when field is blank" do
    get '/api/v1/forecast?location=denver,coloarod'
    expect(response.status).to eq(402)
    error = JSON.parse(response.body)
    expect(error["error"]).to eq("One or more locations are in an incorrect format")
  end

end
