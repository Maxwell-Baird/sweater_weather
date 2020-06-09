class WeatherService

  def one_call(location)
    lat = location[:lat]
    lon = location[:lng]
    response = conn.get("onecall?lat=#{lat}&lon=#{lon}&units=imperial&exclude=minutely")
    body = JSON.parse(response.body, symbolize_names: true)
  end

  private

  def conn
    Faraday.new(url: 'https://api.openweathermap.org/data/2.5/') do |faraday|
      faraday.params["appid"] = "#{ENV['WEATHER_API']}"
    end
  end
end
