class PetsController < ApplicationController
  before_action :authenticate_request, only: [:index, :show, :update, :destroy]
  before_action :set_pet, only: [:show, :update, :destroy]

  def index
    pets = Pet.all
    render json: pets, status: :ok
  end

  def show
    user = User.find_by(username: params[:username])
    pet = user.pet
    render json: PetBlueprint.render{ pet, view:short }, status: :ok
  end

  def create
    pet = @current_user.pets.new(pet_params)

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

  # if post for pet is found, fetch posts associated with that pet
  def posts_index
    if @pet.post.present?
      user = User.find(params[:pet_id])
      pet_posts = pet.posts
      
      render json: pet_posts, status: :ok
    else
      render json: { error: "Post not found for pet" }, status: :not_found
    end
  end

  private

  def set_pet
    @pet = Pet.find(params[:id])
  end

  def pet_params
    params.require(:pet).permit(:name, :species, :breed, :sex, :birthday, :is_vaccinated, :is_fixed, :user_id)
  end
end
