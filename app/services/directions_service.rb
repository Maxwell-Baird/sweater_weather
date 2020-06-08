class DirectionsService

  def directions(start, end)
    response = Faraday.get("https://maps.googleapis.com/maps/api/directions/json?origin=#{start}&destination=#{end}+Hollywood&key=#{ENV['GOOGLE_API']}")
    body = JSON.parse(response.body, symbolize_names: true)
    body["routes"][0]["legs"][0]['duration']
  end
end
