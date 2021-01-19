class WeatherService
  def self.get_weather(latlon)
    response = conn.get('/data/2.5/onecall') do |req|
      req.params['lat'] = latlon.lat
      req.params['lon'] = latlon.lon
      req.params['units'] = 'imperial'
    end
    parse_data(response)
  end

  def self.parse_data(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  private
  def self.conn
    Faraday.new('http://api.openweathermap.org') do |req|
      req.params['appid'] = ENV['OPEN_WEATHER_API_KEY']
    end
  end
end
