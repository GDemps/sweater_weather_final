class YelpService
  def get_rest(destination, cat)
    response = conn.get('businesses/search') do |req|
      req.params['location'] = destination
      req.params['categories'] = cat
    end
    parse_data(response)
  end

  def parse_data(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  private
  def conn
    Faraday.new('https://api.yelp.com/v3/') do |req|
      req.headers['Authorization'] = ENV['YELP_API_KEY']
    end
  end
end
