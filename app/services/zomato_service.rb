class ZomatoService

  def get_restaurant(location)
    lat = location[:lat]
    lon = location[:lng]
    response = conn(lat, lon).get("search")
    body = JSON.parse(response.body, symbolize_names: true)
    binding.pry
  end

  private

  def conn(lat, lon)
    Faraday.new(url: 'https://developers.zomato.com/api/v2.1') do |faraday|
      faraday.headers["user-key"] = "#{ENV['ZOMATO_API']}"
      faraday.params['lat'] = "#{lat}"
      faraday.params['lat'] = "#{lon}"
    end
  end
end
