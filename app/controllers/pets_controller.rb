class PetsController < ApplicationController
  before_action :authenticate_request
  before_action :set_pet, only: [:show, :update, :destroy]

  def index
    pets = Pet.order(created_at: :desc).page(params[:page]).per(12)

    render json: {
      pets: PetBlueprint.render_as_hash(pets, view: :short),
      total_pages: pets.total_pages,
      current_page: pets.current_page
    }
  end

  def show
    if @pet
      render json: PetBlueprint.render_as_hash(@pet, view: :normal, current_user: @current_user), status: :ok
    else
      render json: { error: "Pet not found" }, status: :not_found
    end
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
      render json: PetBlueprint.render(@user, view: :long), status: :ok
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
    if @pet.present?
      pet_posts = @pet.posts
      
      render json: pet_posts, status: :ok
    else
      render json: { error: "Pet post not found" }, status: :not_found
    end
  end

  def user_pets
    user_pets = @current_user.pets

    render json: user_pets, status: :ok
  end
  
  private

  def set_pet
    @pet = @current_user.pets.find_by(id: params[:id])
  end

  def pet_params
    params.permit(:name, :bio, :species, :breed, :sex, :birthday, :is_vaccinated, :is_fixed, :avatar_image)
  end
end
