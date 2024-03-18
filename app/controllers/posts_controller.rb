class PostsController < ApplicationController
  before_action :authenticate_request
  before_action :set_pet_and_profile, only: [:create]
  before_action :set_post, only: [:show, :update, :destroy]

  def index
    posts = @profile.posts.all
    render json: posts, status: :ok
  end

  def show
    render json: @post, status: :ok
  end

  def create
    post = @profile.posts.new(post_params)

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
    @pet = Pet.find(params[:pet_id])
    @profile = @pet.profile
  end

  def set_post
    @post = @profile.posts.find(params[:id])
  end

  # specific pet profile for post
  def post_params
    params.permit(:content)
  end
end
