class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: user_params[:email])
    if user.authenticate(user_params[:password])
      render json: UsersSerializer.new(user)
    else
      render json: ErrorSerializer.new.error('Credential error'), status: :bad_request
    end
  end

  private
  def user_params
    JSON.parse(request.body.read, symbolize_names: true)
        .slice(:email, :password)
  end
end
