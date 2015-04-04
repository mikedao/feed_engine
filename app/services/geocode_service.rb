class GeocodeService
  attr_reader :connection

  def initialize(geo_facet)
    @connection ||= Faraday.new(url: "https://maps.googleapis.com/maps/api/geocode/json?address=#{geo_facet}&key=#{ENV['GOOGLE_GEOCODE_API_KEY']}")
  end

  def latlon
    response_body = parse(connection.get)
    binding.pry
  end

  private

  def parse(data)
    JSON.parse(data.body)
  end
end
