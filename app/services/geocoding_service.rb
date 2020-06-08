class GeocodingService

  def coordinates(location)
    city = location.split(',')[0]
    state = location.split(',')[1]
    response = Faraday.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{city},+#{state}&key=#{ENV['GEOCODING_API']}")
    body = JSON.parse(response.body, symbolize_names: true)
    body[:results][0][:geometry][:location]
  end
end
