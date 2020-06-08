
class Weather

  def initialize(location)
    weather_service = WeatherService.new
    response = weather_service.one_call(location)
    @current = current(response)
    @details = details(response)
    @hourly = hourly(response)
    @week = week(response)
  end

  def current(response)
    hash = Hash.new
    hash[:weather] = response[:current][:weather][0][:main]
    hash[:tempature] = response[:current][:temp]
    hash[:icon] = response[:current][:weather][0][:icon]
    hash[:high] = response[:daily][0][:temp][:max]
    hash[:low] = response[:daily][0][:temp][:min]
    hash[:time] = Time.at(response[:current][:sunrise]).strftime("%I:%M %p, %B %e")
    hash
  end

  def details(response)
    hash = Hash.new
    hash[:weather] = response[:current][:weather][0][:main]
    hash[:feels_like] = response[:current][:feels_like]
    hash[:icon] = response[:current][:weather][0][:icon]
    hash[:humidity] = (response[:current][:humidity] / 1609.344)
    hash[:uv] = response[:current][:uvi]
    hash[:visibility] = response[:current][:visibility]
    hash[:sun_rise] = Time.at(response[:current][:sunrise]).strftime("%I:%M %p")
    hash[:sun_set] = Time.at(response[:current][:sunset]).strftime("%I:%M %p")
    hash
  end

  def hourly(response)
    hourly = []
    count = 0
    8.times do
      hash = Hash.new
      hash[:weather] = response[:hourly][count][:weather][0][:main]
      hash[:icon] = response[:hourly][count][:weather][0][:icon]
      hash[:hour] =Time.at(response[:hourly][count][:dt]).strftime("%I:%M %p")
      count += 1
      hourly << hash
    end
    hourly
  end

  def week(response)
    weekly = []
    count = 1
    6.times do
      hash = Hash.new
      hash[:weather] = response[:daily][count][:weather][0][:main]
      hash[:icon] = response[:daily][count][:weather][0][:icon]
      hash[:high] = response[:daily][count][:temp][:max]
      hash[:low] = response[:daily][count][:temp][:min]
      hash[:precipitation] = response[:daily][count][:rain]
      hash[:day] =Time.at(response[:daily][count][:dt]).strftime("%A")
      count += 1
      weekly << hash
    end
    weekly
  end
end
