class UsersController < ApplicationController
  before_action :authenticate_request, except: [:create]

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def show 
    user = User.find_by(id: params[:id])

    render json: UserBlueprint.render(user, view: :normal), status: :ok
  end

  private

  def user_params
    # params.require(:user)
    params.permit(:username, :email, :password, :password_confirmation)
  end
end
