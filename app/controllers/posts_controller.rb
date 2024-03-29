class PostsController < ApplicationController
  # before_action :authenticate_request
  before_action :set_pet_and_profile, only: [:create]
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

  def set_pet_and_profile
    @pet = Pet.find_by(params[:pet_id])
    @profile = @pet.profile
  end

  def set_post
    @post = Post.find_by(params[:id])
  end

  # specific pet profile for post
  def post_params
    params.permit(:content, :profile_id)
  end
end
