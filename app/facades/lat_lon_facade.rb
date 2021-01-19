class LatLonFacade
  def self.get_coordinates(location)
    coordinates = LatLonService.new.get_coordinates(location)
    LatLon.new(coordinates)
  end

  # def self.get_trip(origin, destination)
  #   trip_duration = LatLonService.get_trip_duration(origin, destination)
  # end
end
