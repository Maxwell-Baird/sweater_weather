
class Weather
  attr_accessor :id, :current, :details, :hourly, :week

  def initialize(location)
    weather_service = WeatherService.new
    response = weather_service.one_call(location)
    @current = current_hash(response)
    @details = details_hash(response)
    @hourly = hourly_hash(response)
    @week = week_hash(response)
    @id = 1
  end

  def current_hash(response)
    hash = Hash.new
    hash[:weather] = response[:current][:weather][0][:main]
    hash[:tempature] = response[:current][:temp]
    hash[:icon] = response[:current][:weather][0][:icon]
    hash[:high] = response[:daily][0][:temp][:max]
    hash[:low] = response[:daily][0][:temp][:min]
    hash[:time] = Time.at(response[:current][:sunrise]).strftime("%I:%M %p, %B %e")
    hash
  end

  def details_hash(response)
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

  def hourly_hash(response)
    hourly = []
    count = 0
    8.times do
      hash = Hash.new
      hash[:tempature] = response[:hourly][count][:temp]
      hash[:weather] = response[:hourly][count][:weather][0][:main]
      hash[:icon] = response[:hourly][count][:weather][0][:icon]
      hash[:hour] =Time.at(response[:hourly][count][:dt]).strftime("%I:%M %p")
      count += 1
      hourly << hash
    end
    hourly
  end

  def week_hash(response)
    weekly = []
    count = 1
    6.times do
      hash = Hash.new
      hash[:weather] = response[:daily][count][:weather][0][:main]
      hash[:icon] = response[:daily][count][:weather][0][:icon]
      hash[:high] = response[:daily][count][:temp][:max]
      hash[:low] = response[:daily][count][:temp][:min]
      if response[:daily][count][:rain].nil?
        hash[:precipitation] = 0.0
      else
        hash[:precipitation] = response[:daily][count][:rain]
      end
      hash[:day] =Time.at(response[:daily][count][:dt]).strftime("%A")
      count += 1
      weekly << hash
    end
    weekly
  end
end
