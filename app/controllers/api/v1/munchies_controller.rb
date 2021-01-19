class Api::V1::MunchiesController < ApplicationController
  def index
    coords = MunchiesFacade.new.get_coordinates(params[:start], params[:end])
    # forecast = ForecastFacade.get_forecast(location_params)
    # render json: ForecastSerializer.new(forecast)
  end

  private
  def location_params
    params.permit(:location)
  end
end
