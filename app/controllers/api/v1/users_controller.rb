class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      render json: UsersSerializer.new(user), status: :created
    else
      render json: ErrorSerializer.new.error(user.errors.full_messages.to_sentence), status: :bad_request
    end
  end

  private
  def user_params
    JSON.parse(request.body.read, symbolize_names: true)
        .slice(:email, :password, :password_confirmation)
  end
end
