class PostsController < ApplicationController
  before_action :authenticate_request
  before_action :set_post, only: [:show, :update, :destroy]

  def index
    posts = Post.all
    render json: posts, status: :ok
  end

  def show
    render json: @post, status: :ok
  end

  def create
    pet = Pet.find_by(params[:pet_id])
    if pet.nil?
      render json: { error: "Pet not found" }, status: :not_found
      return
    end
    
    post = pets.posts.new(post_params)
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

  def like
    # grab the post and create a like w/ that post and curr user's id & redirect back to that post
    @post = Post.all.find(params[:id])
    Like.create(user_id: @current_user.id, post_id: @post.id)
    redirect_to post_path(@post)
  end

  def destroy
    if @post.destroy
      render json: nil, status: :ok
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  private

  def set_post
    @post = Post.find_by(params[:id])
  end

  def post_params
    params.permit(:content, :pet_id, :images [])
  end
end
