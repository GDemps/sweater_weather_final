class Api::V1::ForecastController < ApplicationController
  def index
    forecast = ForecastFacade.get_forecast(location_params)
    render json: ForecastSerializer.new(forecast)
  end

  private
  def location_params
    params.permit(:location)
  end
end
