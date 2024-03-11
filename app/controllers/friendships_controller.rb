class FriendshipsController < ApplicationController
  before_action :authenticate_request

  def create
    friendship = Friendship.new(friendship_params)
    if friendship.save
      render json: friendship, status: :created
    else
      render json: friendship.errors, status: :unprocessable_entity
    end
  end

  private

  def friendship_params
    params.permit(:pet_id, :friend_id)
  end
end
end
