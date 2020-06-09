class FoodieSerializer
  include FastJsonapi::ObjectSerializer
    set_id :id
    attributes :end_location, :travel_time, :forecast, :restaurant
end
