class MunchiesFacade

  def get_destination_city(start_here, destination, cat)
    coords = LatLonFacade.get_coordinates(destination)
    travel_time = self.get_travel_time(start_here, destination)
    dest = DestinationCity.new(coords)
    forecast = ForecastFacade.get_forecast(destination)
    restaurant = RestaurantFacade.get_restaurant(destination, cat)
  end

  def get_travel_time(start_here, destination)
    tt = EstTravelFacade.get_travel_time(start_here, destination)
    trav_time = TravTime.new(tt)
  end

end
