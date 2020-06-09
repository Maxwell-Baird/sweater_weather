class PhotosService

  def photo_url(location)
    search = conn.get("findplacefromtext/json?input=#{location}&inputtype=textquery&fields=photos")
    reference = JSON.parse(search.body, symbolize_names: true)
    photoreference = reference[:candidates][0][:photos][0][:photo_reference]
    response = conn.get("photo?maxwidth=1600&photoreference=#{photoreference}")
    response.env["response_headers"][:location]
  end

  private

  def conn
    Faraday.new(url: 'https://maps.googleapis.com/maps/api/place/') do |faraday|
      faraday.params["key"] = "#{ENV['GOOGLE_API']}"
    end
  end
end
