class ProfilesController < ApplicationController
  before_action :authenticate_request
  before_action :set_owner, only: [:create, :destroy]
  before_action :set_pet, only: [:create, :destroy]
  before_action :set_profile, only: [:show, :update, :destroy]

  def show
    render json: @profile, status: :ok
  end

  # builds pet profile if associated pet_id is found, otherwise builds owner profile
  # build_profile automatically handles associations
  def create
    if params[:pet_id].present?
      @pet = Pet.find_by(params[:pet_id])
      @profile = @pet.build_profile(profile_params)
    else
      @profile = @owner.build_profile(profile_params)
    end

    if @profile.save
      render json: @profile, status: :created
    else
      render json: @profile.errors, status: :unprocessable_entity
    end
  end

  def update
    if @profile.update(profile_params)
      render json: @profile, status: :ok
    else
      render json: @profile.errors, status: :unprocessable_entity
    end
  end

  # destroy profile associated with pet if pet_id provided, otherwise destroys owner profile
  def destroy
    if params[:pet_id].present?
      @pet = Pet.find(params[:pet_id])
      if @pet.profile.destroy
        render json: nil, status: :ok
    else
        render json: @pet.profile.errors, status: :unprocessable_entity
    end
  else
    if @owner.profile.destroy
      render json: nil, status: :ok
      else
        render json: @owner.profile.errors, status: :unprocessable_entity
      end
    end
  end

  private 

  def set_pet
    @pet = Pet.find(params[:pet_id])
  end

  def set_owner
    @owner = Owner.find(params[:owner_id])
  end

  # checks profile associated with pet, otherwise checks for owner profile
  def set_profile
    @profile = params[:pet_id] ? Profile.find_by(pet_id: params[:pet_id]) : @owner.profile
  end

  def profile_params
    params.permit(:bio, :pet_id, :owner_id)
  end
end
