class PostsController < ApplicationController
  # before_action :authenticate_request
  before_action :set_pet, only: [:create]
  before_action :set_post, only: [:show, :update, :destroy]

  def index
    posts = @pet.posts.all
    # posts = Post.all
    render json: posts, status: :ok
  end

  def show
    render json: @post, status: :ok
  end

  def create
    pet = Pet.find_by(id: params[:pet_id])
    if pet.nil?
      render json: { error: "Pet not found" }, status: :not_found
      return
    end
    
    profile = pet.profile
    if profile.nil?
      render json: { error: "Profile not found for the pet" }, status: :not_found
      return
    end
    
    post = profile.posts.new(post_params)
    if post.save
      render json: post, status: :created
    else
      render json: post.errors, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      render json: @post, status: :ok
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @post.destroy
      render json: nil, status: :ok
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  private

  def set_pet
    @pet = Pet.find_by(params[:id])
  end

  def set_post
    @post = Post.find_by(params[:id])
  end

  # specific pet for post
  def post_params
    params.permit(:content, :pet_id, :images [])
  end
end
