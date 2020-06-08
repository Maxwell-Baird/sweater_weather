class Api::V1::BackgroundController < ApplicationController

  def show
    response = PhotosService.new
    url = Hash.new
    url[:url] = response.photo_url(params[:location])
    render json: url
  end

end
