class Api::V1::RoadTripController < ApplicationController
  def create
    user = User.find_by(api_key)
    if user
      render json: RoadTripSerializer.new(road_trip(params[:origin], params[:destination]))
    else
      render json: ErrorSerializer.new.error('Credentials are bad'), status: :unauthorized
    end
  end

  private

  def road_trip(origin, destination)
    directions = LatLonFacade.new.directions(origin, destination)
    location = LatLonFacade.get_coordinates(destination)
    forecast = ForecastFacade.get_forecast(location)
    RoadTrip.new(origin, destination, directions, forecast)
  end

  def api_key
    JSON.parse(request.body.read, symbolize_names: true).slice(:api_key)
  end
end
