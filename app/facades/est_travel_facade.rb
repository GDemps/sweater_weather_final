class EstTravelFacade
  def self.get_travel_time(start_here, destination)
    hash = TravelTimeService.get_tt(start_here, destination)

    # coords = LatLonFacade.get_time(location)
    # self.get_weather(coords)
  end
end
