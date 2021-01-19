class EstTravelFacade
  def self.get_travel_time(start_here, destination)
    TravelTimeService.get_tt(start_here, destination)
  end
end
