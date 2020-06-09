require 'rails_helper'

describe "Weather API" do
  it "sends a data about the upcoming week" do
    get '/api/v1/forecast?location=denver,co'

    expect(response).to be_successful

    weather = JSON.parse(response.body)
    
    expect(weather['data']["attributes"]['week'].count).to eq(6)
    expect(weather['data']["attributes"]['week'][0]['weather']).to be_a(String)
    expect(weather['data']["attributes"]['week'][0]['icon']).to be_a(String)
    expect(weather['data']["attributes"]['week'][0]['day']).to be_a(String)
    expect(weather['data']["attributes"]['week'][0]['high']).to be_a(Float)
    expect(weather['data']["attributes"]['week'][0]['low']).to be_a(Float)
    expect(weather['data']["attributes"]['week'][0]['precipitation']).to be_a(Float)
  end

  it "sends a data about the upcoming hours" do
    get '/api/v1/forecast?location=denver,co'

    expect(response).to be_successful

    weather = JSON.parse(response.body)
    expect(weather['data']["attributes"]['hourly'].count).to eq(8)
    expect(weather['data']["attributes"]['hourly'][0]['weather']).to be_a(String)
    expect(weather['data']["attributes"]['hourly'][0]['icon']).to be_a(String)
    expect(weather['data']["attributes"]['hourly'][0]['hour']).to be_a(String)
    expect(weather['data']["attributes"]['hourly'][0]['tempature']).to be_a(Float)
  end

  it "sends a data about the details" do
    get '/api/v1/forecast?location=denver,co'

    expect(response).to be_successful

    weather = JSON.parse(response.body)
    expect(weather['data']["attributes"]['details']['weather']).to be_a(String)
    expect(weather['data']["attributes"]['details']['icon']).to be_a(String)
    expect(weather['data']["attributes"]['details']['sun_rise']).to be_a(String)
    expect(weather['data']["attributes"]['details']['sun_set']).to be_a(String)
    expect(weather['data']["attributes"]['details']['feels_like']).to be_a(Float)
    expect(weather['data']["attributes"]['details']['uv']).to be_a(Float)
    expect(weather['data']["attributes"]['details']['humidity']).to be_a(Float)
  end

  it "sends a data about the current weather" do
    get '/api/v1/forecast?location=denver,co'

    expect(response).to be_successful

    weather = JSON.parse(response.body)

    expect(weather['data']["attributes"]['current']['weather']).to be_a(String)
    expect(weather['data']["attributes"]['current']['icon']).to be_a(String)
    expect(weather['data']["attributes"]['current']['time']).to be_a(String)
    expect(weather['data']["attributes"]['current']['high']).to be_a(Float)
    expect(weather['data']["attributes"]['current']['low']).to be_a(Float)
    expect(weather['data']["attributes"]['current']['tempature']).to be_a(Float)

  end

end
