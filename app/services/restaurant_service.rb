class RestaurantService
  def get_restaurant(latlon, search)
    response = conn.get('/api/v2.1/search') do |req|
      req.params['search'] = search
      req.params['lat'] = latlon.lat
      req.params['lon'] = latlon.lon
      req.params['count'] = 1
    end
    parse_data(response)
  end

  def parse_data(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  private
  def conn
    Faraday.new('https://developers.zomato.com') do |req|
      req.headers['user-key'] = ENV['ZOMATO_API_KEY']
    end
  end
end
