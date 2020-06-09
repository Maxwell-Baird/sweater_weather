class Api::V1::UsersController < ApplicationController

  def create
    if params[:email].nil? || params[:password].nil? || params[:password_confirmation].nil?
      render json: {error: "One or more fields are blank"}, status: 401
    else
      if params[:password] != params[:password_confirmation]
        render json: {error: "Passwords do not match"}, status: 402
      else
        user = User.create(user_params)
        if user.save
          user.generate_api_key
          render json: UserSerializer.new(user), status: 201
        else
          render json: {error: "Email already in use"}, status: 403
        end
      end
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end

end
