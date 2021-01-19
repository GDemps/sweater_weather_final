class RestaurantFacade

  def self.get_restaurant(destination, cat)
    rest = YelpService.new.get_rest(destination, cat)
    Rests.new(rest)
  end

end
