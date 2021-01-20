class RestaurantFacade
  def self.get_restaurant(location, search)
    resp = RestaurantService.new.get_restaurant(location, search)
    Restaurant.new(resp)
  end
end
