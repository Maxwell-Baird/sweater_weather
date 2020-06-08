require 'rails_helper'

describe "Background API" do
  it "sends a url back" do
    get '/api/v1/backgrounds?location=denver,co'

    expect(response).to be_successful

    weather = JSON.parse(response.body)

  end
end
