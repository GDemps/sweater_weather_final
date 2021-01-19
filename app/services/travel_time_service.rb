class TravelTimeService

  def self.get_tt(start_here, destination)
    response = conn.get('route') do |req|
      req.params['from'] = start_here
      req.params['to'] = destination
    end
    parse_data(response)
  end

  def self.parse_data(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def self.conn
    Faraday.new('http://www.mapquestapi.com/directions/v2') do |conn|
      conn.params['key'] = ENV['MAPQUEST_API_KEY']
    end
  end
end
