class PetsController < ApplicationController
  before_action :authenticate_request, only: [:index, :show, :update, :destroy]
  before_action :set_pet, only: [:show, :update, :destroy, :posts_index]

  def index
    pets = Pet.all
    render json: pets, status: :ok
  end

  def show
    render json: { pet: @pet, age: @pet.age }, status: :ok
  end

  def create
    pet = Pet.new(pet_params)

    if pet.save
      render json: pet, status: :created
    else
      render json: pet.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    if @pet.update(pet_params)
      render json: @pet, status: :ok
    else
      render json: @pet.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @pet.destroy
      render json: nil, status: :ok
    else
      render json: @pet.errors, status: :unprocessable_entity
    end
  end

  # if profile for pet is found, fetch posts associated with that profile 
  def posts_index
    if @pet.profile.present?
      pet_posts = @pet.profile.posts
      render json: pet_posts, status: :ok
    else
      render json: { error: "Profile not found for the pet" }, status: :not_found
    end
  end

  private

  def set_pet
    @pet = Pet.find(params[:id])
  end

  def pet_params
    params.require(:pet).permit(:name, :species, :breed, :sex, :birthday, :is_vaccinated, :is_fixed, :owner_id)
  end
end
