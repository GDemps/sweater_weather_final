class Api::V1::MunchiesController < ApplicationController
  def index
    coords = MunchiesFacade.new.get_destination_city(params[:start], params[:end])
    # render json: ForecastSerializer.new(forecast)
  end

  private
  def location_params
    params.permit(:location)
  end
end
