class GeocodingService

  def coordinates(location)
    city = location.split(',')[0]
    state = location.split(',')[1]
    response = conn.get("json?address=#{city},+#{state}")
    body = JSON.parse(response.body, symbolize_names: true)
    body[:results][0][:geometry][:location]
  end

  private

  def conn
    Faraday.new(url: 'https://maps.googleapis.com/maps/api/geocode/') do |faraday|
      faraday.params["key"] = "#{ENV['GOOGLE_API']}"
    end
  end
end
