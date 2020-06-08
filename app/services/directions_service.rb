class DirectionsService

  def directions(start_point, end_point)
    response = Faraday.get("https://maps.googleapis.com/maps/api/directions/json?origin=#{start_point}&destination=#{end_point}+Hollywood&key=#{ENV['GOOGLE_API']}")
    body = JSON.parse(response.body, symbolize_names: true)
    body[:routes][0][:legs][0][:duration][:text]
  end
end
