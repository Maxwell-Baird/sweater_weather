class Api::V1::FoodieController < ApplicationController

  def show
    foodie = Foodie.new(params[:start],params[:end])
  end

end
