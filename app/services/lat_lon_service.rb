class LatLonService

  def get_coordinates(location)
    response = conn.get('address') do |req|
      req.params['location'] = location
      req.params['maxResults'] = 1
    end
    parse_data(response)
  end

  def directions(origin, destination)
    resp = conn.get('/directions/v2/route') do |req|
      req.params['from'] = origin
      req.params['to'] = destination
    end
    parse_data(resp)
  end

  def parse_data(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def conn
    Faraday.new('http://www.mapquestapi.com/geocoding/v1') do |conn|
      conn.params['key'] = ENV['MAPQUEST_API_KEY']
    end
  end
end
