class Api::V1::MunchiesController < ApplicationController
  def index
    coords = MunchiesFacade.new.get_destination_city(params[:start], params[:end], params[:cat])
    est_travel = EstTravelFacade.get_travel_time(params[:start], params[:end])
    render json: MunchiesSerializer.new(params[:start], params[:end], params[:cat])
  end

  private
  def location_params
    params.permit(:location)
  end
end
