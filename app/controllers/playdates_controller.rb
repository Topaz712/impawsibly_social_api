class PlaydatesController < ApplicationController
  before_action :set_playdate, only: [:show, :update, :destroy]
  before_action :authenticate_request, except: [:index]

  def index
    playdates = Playdate.order(created_at: :desc).page(params[:page]).per(12)

    render json: {
      playdates: PlaydateBlueprint.render_as_hash(playdates, view: :short),
      total_pages: playdates.total_pages,
      current_page: playdates.current_page
    }
  end

  # localhost:3000/playdates/:id
  def show
    render json: PlaydateBlueprint.render_as_hash(@playdate, view: :long, current_user: @current_user), status: :ok
  end

  def create
    playdate = @current_user.created_playdates.new(playdate_params)

    if playdate.save
      render json: playdate, status: :created

    else
      render json: playdate.errors, status: :unprocessable_entity
    end
  end

  def update
    if @playdate.update(playdate_params)
      render json: @playdate, status: :ok
    else
      render json: @playdate.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @playdate.destroy
      render json: nil, status: :ok
    else
      render json: @playdate.errors, status: :unprocessable_entity
    end
  end

  def rate
    @playdate = Playdate.find(params[:id])
    rating = params[:rating].to_i

    if (1..5).include?(rating)
      current_user.rate_playdate(@playdate, rating)
      render json: @playdate, status: :ok
    else
      render json: @playdate.errors, status: :unprocessable_entity
    end
  end

  def join
    playdate = Playdate.find(params[:playdate_id])

    # check if the current user is the playdate creator
    return render json: { error: "You can't join your own playdate." }, status: :unprocessable_entity if playdate.creator.id == @current_user.id

    # check if the event is full
    return render json: { error: "Playdate is full, please join a different Playdate." }, status: :unprocessable_entity if playdate.pet_participants.count >= playdate.pet_limit

    # check if the current user is already a participant
    return render json: { error: "You are already a participant." }, status: :unprocessable_entity if playdate.human_participants.include?(@current_user)

     # fetch the pets of the curr user to let them pick which one to join
    user_pets = @current_user.pets
    render json: user_pets, status: :ok

    # checks if user has pets
    return render json: { error: "You don't have any pets to join the playdate with." }, status: :unprocessable_entity if user_pets.empty?

     # after going through validations, add current user and pet to list of playdate participants
     playdate.human_participants << @current_user

     pet_id = params[:selected_pet]
     pet = user_pets.find_by(id: pet_id)
     playdate.pet_participants << pet

    # trigger a playdate event to the creator/user
    Pusher.trigger(playdate.creator.id, 'notification', {
      playdate_id: playdate.id,
      notification: "#{@current_user.username} has joined #{playdate.title} with their pet named #{pet.name}!"
    })

    head :ok
  end

  def leave
    playdate = Playdate.find(params[:playdate_id])

    playdate.human_participants.delete(@current_user)

    Pusher.trigger(playdate.creator.id, 'notification', {
      playdate_id: playdate.id,
      notification: "#{@current_user.username} has left the #{playdate.title}!"
    })

    head :ok
  end

  private 
  
  def set_playdate
    @playdate = Playdate.find(params[:id])
  end

  def playdate_params
    params.permit(:title, :content, :species_specific, :pet_limit, :start_date_time, :end_date_time, :cover_image, :pet_id)
  end
end
