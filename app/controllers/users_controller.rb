class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy] 
  before_action :set_playdate_and_rating, only: [:rate_playdate]
  before_action :authenticate_request, except: [:create]

  def index
    users = User.all

    render json: users, status: 200
  end

  def show 
    user = User.find_by(id: params[:id])

    render json: UserBlueprint.render(@user, view: :normal), status: :ok
  end

  def create
    user = User.new(user_params)

    if user.save
      render json: user, status: :created
    else
      render json: user.errors.full_messages, status: :unprocessable_entity
    end
  end


  def update
    if @user.update(user_params)
      render json: @user, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @user.destroy
      render json: nil, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def user_pets
    user_pets = @current_user.pets

    render json: user_pets, status: :ok
  end

  def rate_playdate
    # user can only rate a playdate if they are a participant of that playdate
    @playdate_participant = @current_user.playdate_participants.find_by(playdate_id: @playdate.id)
    return unless @playdate_participant

    @playdate_participant.update(rating: params[:rating])
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_playdate_and_playdate_participant
    @playdate = Playdate.find_by(id: (params[:id]))
    return unless @playdate

    @playdate_participant = @current_user.playdate_participants.find_by(playdate_id: @playdate.id)
  end
  
  def user_params
    params.permit(:username, :first_name, :last_name, :email, :password, :password_confirmation, :avatar_image)
  end
end
