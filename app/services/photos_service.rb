class PhotoService

  def photo_url(location)
    reference = Faraday.get("https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=#{location}&inputtype=textquery&fields=photos&key=#{ENV['GOOGLE_API']}")
    response = Faraday.get("https://maps.googleapis.com/maps/api/place/photo?maxwidth=1600&photoreference=#{reference}&key=#{ENV['GOOGLE_API']}")
    body = JSON.parse(response.body, symbolize_names: true)
    binding.pry
  end
end
