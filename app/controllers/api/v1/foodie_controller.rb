class Api::V1::FoodieController < ApplicationController
  def index
    directions = LatLonFacade.new.directions(params[:start], params[:end])
    location = LatLonFacade.get_coordinates(params[:end])
    forecast = ForecastFacade.get_forecast(location)
    restaurant = RestaurantFacade.get_restaurant(location, params[:search])
    foodie = Foodie.new(directions, location, forecast, restaurant)
    render json: FoodieSerializer.new(foodie)
  end
end
