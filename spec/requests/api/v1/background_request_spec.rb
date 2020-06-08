require 'rails_helper'

describe "Background API" do
  it "sends a url back" do
    get '/api/v1/backgrounds?location=denver,co'
    expect(response).to be_successful
    photo = JSON.parse(response.body)
    expect(photo["url"]).to eq("https://lh3.googleusercontent.com/p/AF1QipOB9bbho9gPmGyOjUX5of99x-LRYfH_RNETR9EX=s1600-w849")
  end
end
