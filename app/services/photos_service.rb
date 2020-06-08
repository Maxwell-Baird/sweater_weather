class PhotosService

  def photo_url(location)
    search = Faraday.get("https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=#{location}&inputtype=textquery&fields=photos&key=#{ENV['GOOGLE_API']}")
    reference = JSON.parse(search.body, symbolize_names: true)
    photoreference = reference[:candidates][0][:photos][0][:photo_reference]
    response = Faraday.get("https://maps.googleapis.com/maps/api/place/photo?maxwidth=1600&photoreference=#{photoreference}&key=#{ENV['GOOGLE_API']}")
    response.env["response_headers"][:location]
  end
end
