class Foodie

  def initialize(start_point,end_point)
    @coordinates = get_coordinates(end_point)
    @travel_time = find_duration(start_point,end_point)
    @end_location = end_point
    @forecast = find_forecast(@coordinates)
    @restaurant = find_restaurant(@coordinates)
  end

  private

  def get_coordinates(end_point)
    geocode = GeocodingService.new
    geocode_response = geocode.coordinates(end_point)
  end

  def find_forecast(geocode_response)
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
    hash[:temperature] = response[:current][:temp]
    hash[:summary] = response[:current][:weather][0][:description]
    hash
  end

  def find_restaurant(geocode_response)
    zomato = ZomatoService.new
    response = zomato.get_restaurant(geocode_response)
  end
end
