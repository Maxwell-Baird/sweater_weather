class DirectionsService

  def directions(start_point, end_point)
    response = conn.get("json?origin=#{start_point}&destination=#{end_point}}")
    body = JSON.parse(response.body, symbolize_names: true)
    body[:routes][0][:legs][0][:duration][:text]
  end

  private

  def conn
    Faraday.new(url: 'https://maps.googleapis.com/maps/api/directions/') do |faraday|
      faraday.params["key"] = "#{ENV['GOOGLE_API']}"
    end
  end

end
