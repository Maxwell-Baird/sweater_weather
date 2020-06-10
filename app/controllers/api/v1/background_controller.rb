class Api::V1::BackgroundController < ApplicationController

  def show
    if params[:location].nil?
      render json: {error: "One or more fields are blank"}, status: 401
    else
      if check_location_valid(params[:location])
        response = PhotosService.new
        url = Hash.new
        url[:url] = response.photo_url(params[:location])
        render json: url
      else
        render json: {error: "One or more locations are in an incorrect format"}, status: 402
      end
    end

  end

  private

  def check_location_valid(location)
    location.split(',').length == 2 && location.split(',')[1].length == 2
  end

end
