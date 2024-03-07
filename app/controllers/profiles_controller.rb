class ProfilesController < ApplicationController
  before_action :authenticate_request
  before_action :set_pet, only: [:create, :show, :update, :destroy]

  def show
    profile = @pet.profile
    render json: profile, status: :ok
  end

  def create
    profile = @pet.build_profile(profile_params)
    if profile.save
      render json: profile, status: :created
    else
      render json: profile.errors, status: :unprocessable_entity
    end
  end

  def update
    if @pet.profile.update(profile_params)
      render json: @pet.profile, status: :ok
    else
      render json: @pet.profile.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @pet.profile.destroy
      render json: nil, status: :ok
    else
      render json: @pet.profile.errors, status: :unprocessable_entity
    end
  end

  private 
  
  def set_pet
    @pet = Pet.find(params[:pet_id])
  end

  def profile_params
    params.require(:profile).permit(:bio)
  end
end
