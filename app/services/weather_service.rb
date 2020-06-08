class WeatherService

  def one_call(location)
    lat = location[:lat]
    lon = location[:lng]
    response = Faraday.get("https://api.openweathermap.org/data/2.5/onecall?lat=#{lat}&lon=#{lon}&units=imperial&exclude=minutely&appid=#{ENV['WEATHER_API']}")
    body = JSON.parse(response.body, symbolize_names: true)
  end
end
