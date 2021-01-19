class MunchiesFacade

  def get_destination_city(start, destination)
    coords = LatLonFacade.get_coordinates(destination)
    dest = DestinationCity.new(coords)
    travel_time = EstTravelFacade.get_travel_time(start, destination)
  end
end
