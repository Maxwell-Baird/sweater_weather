class RoadTripSerializer
  include FastJsonapi::ObjectSerializer
    set_id :id
    attributes :origin, :travel_time, :forecast, :destination
end
