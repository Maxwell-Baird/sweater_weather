class Api::V1::RoadTripController < ApplicationController

  def show
    if params[:origin].nil? || params[:api_key].nil? || params[:destination].nil?
      render json: {error: "One or more fields are missing"}, status: 403
    else
      if User.find_by(api_key: params[:api_key]).nil?
        render json: {error: "Api key is wrong"}, status: 401
      else
        if check_location_valid(params[:origin]) && check_location_valid(params[:destination])
          road_trip = RoadTrip.new(params[:origin], params[:destination])
          render json: RoadTripSerializer.new(road_trip)
        else
          render json: {error: "One or more locations are in an incorrect format"}, status: 402
        end
      end
    end
  end

  private

  def check_location_valid(location)
    location.split(',').length == 2 && location.split(',')[1].length == 2
  end

end
