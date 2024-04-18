class PostsController < ApplicationController
  before_action :authenticate_request
  before_action :set_post, only: [:show, :update, :destroy]

  def index
    posts = Post.all
    render json: PostBlueprint.render(posts, view: :profile), status: :ok
  end

  def show
    render json: @post, status: :ok
  end

  def create
    @pet = Pet.find_by(id: params[:pet_id])

    if @pet.nil?
      render json: { error: "Pet not found" }, status: :not_found
    return
  end

    post = @current_user.posts.new(post_params)
    post.images.attach(params[:images])
    puts post.images.attached?
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
    # grab the post and create a like w/ that post and curr user's id 
    @post = Post.find(params[:id])
    like = Like.new(user_id: @current_user.id, post_id: @post.id)

    if like.save
      render json: { message: "Post liked successfully" }, status: :ok
    else
      render json: { error: "Failed to like the post" }, status: :unprocessable_entity
    end
  end

  def unlike
    @post = Post.find(params[:id])
    like = Like.find_by(user_id: @current_user.id, post_id: @post.id)

    if like
      like.destroy
      render json: { message: "Post unliked successfully" }, status: :ok
    else
      render json: { error: "You have not liked this post yet" }, status: :unprocessable_entity
    end
  end

  def create_comment
    @post = Post.find(params[:id])
    comment = @post.comments.new(comment_params)
    comment.user_id = @current_user.id
  
    if comment.save
      render json: comment, status: :created
    else
      render json: comment.errors, status: :unprocessable_entity
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

  def set_post
    @post = Post.find_by(params[:id])
  end

  def comment_params
    params.permit(:content, :user_id)
  end

  def post_params
    params.permit(:content, :pet_id, :user_id, :images)
  end
end
