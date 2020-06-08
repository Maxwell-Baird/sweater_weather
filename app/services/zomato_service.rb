class ZomatoService

  def get_restaurant(location,search)
    lat = location[:lat]
    lon = location[:lng]
    response = conn(lat, lon).get("search")
    body = JSON.parse(response.body, symbolize_names: true)
    find_cuisine(body, search)
  end

  private

  def find_cuisine(body, search)
    body[:restaurants].find do |response|
      response[:restaurant][:cuisines].include?(search.capitalize)
    end
  end

  def conn(lat, lon)
    Faraday.new(url: 'https://developers.zomato.com/api/v2.1') do |faraday|
      faraday.headers["user-key"] = "#{ENV['ZOMATO_API']}"
      faraday.params['lat'] = "#{lat}"
      faraday.params['lon'] = "#{lon}"
    end
  end
end
