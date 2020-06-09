class Api::V1::SessionsController < ApplicationController

  def create
    if params[:email].nil? || params[:password].nil?
      render json: {error: "One or more fields are blank"}, status: 401
    else
      user = User.find_by(email: params[:email])
      if user.nil?
        render json: {error: "User does not exist"}, status: 403
      else
        if user.authenticate(params[:password])
          render json: UserSerializer.new(user), status: 200
        else
          render json: {error: "Password does not match"}, status: 402
        end
      end
    end
  end
end
