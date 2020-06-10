require 'rails_helper'

describe "Background API" do
  it "sends a url back", :vcr do
    get '/api/v1/backgrounds?location=denver,co'
    expect(response).to be_successful
    photo = JSON.parse(response.body)
    expect(photo["url"]).to eq("https://lh3.googleusercontent.com/p/AF1QipOB9bbho9gPmGyOjUX5of99x-LRYfH_RNETR9EX=s1600-w849")
  end

  it "errors out when field is blank" do
    get '/api/v1/backgrounds?'
    expect(response.status).to eq(401)
    error = JSON.parse(response.body)
    expect(error["error"]).to eq("One or more fields are blank")
  end

  it "errors out when location wrong format" do
    get '/api/v1/backgrounds?location=denvercolorado'
    expect(response.status).to eq(402)
    error = JSON.parse(response.body)
    expect(error["error"]).to eq("One or more locations are in an incorrect format")
  end
end
