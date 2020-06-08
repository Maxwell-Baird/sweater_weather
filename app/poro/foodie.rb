class Foodie

  def initialize(start_point,end_point)
    @travel_time = find_duration(start_point,end_point)
    @end_location = end_point
    @forecast = find_forecast(end_point)
  end

  private

  def find_forecast(end_point)
    geocode = GeocodingService.new
    geocode_response = geocode.coordinates(end_point)
    weather_service = WeatherService.new
    response = weather_service.one_call(geocode_response)
    forecast_parse(response)
  end

  def find_duration(start_point,end_point)
    response = DirectionsService.new
    response.directions(start_point,end_point)
  end

  def forecast_parse(response)
    hash = Hash.new
    time_rounded_up = @travel_time[0].to_i + 2
    if time_rounded_up < 48
      hash[:temperature] = response[:hourly][time_rounded_up][:temp]
      hash[:summary] =
    else
    end
  end
end
