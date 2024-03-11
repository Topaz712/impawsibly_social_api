class FriendshipRequestsController < ApplicationController
  before_action :authenticate_request

  def create
    friendship_request = current_user.sent_friendship_requests.build(friendship_request_params)
    if friendship_request.save
      render json: friendship_request, status: :created
    else
      render json: friendship_request.errors, status: :unprocessable_entity
    end
  end

  private

  def friendship_request_params
    params.permit(:recipient_id)
  end
end
