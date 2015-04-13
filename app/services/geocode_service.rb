class GeocodeService
  attr_reader :connection

  def initialize
    @connection = Faraday.new(url: "https://maps.googleapis.com/maps/api/geocode")
  end

  def geocode_info(geo_facet)
    parse(connection.get("json?key=#{ENV['google_geocode_api_key']}&address=#{geo_facet}"))
  end

  private

  def parse(data)
    JSON.parse(data.body)
  end
end
