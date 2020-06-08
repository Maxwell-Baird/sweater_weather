class WeatherSerializer
  include FastJsonapi::ObjectSerializer
    set_id :id
    attributes :current, :details, :hourly, :week
end
