class Api::V1::BackgroundController < ApplicationController

  def show
    geocode = GeocodingService.new
    response = geocode.coordinates(params[:location])
    weather = Weather.new(response)
    render json: WeatherSerializer.new(weather)
  end

end
