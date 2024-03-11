class OwnersController < ApplicationController
  before_action :set_owner, only: [:show, :update, :destroy]
  before_action :authenticate_request, only: [:index, :show, :update, :destroy]

  def index
    owners = Owner.all

    render json: owners, status: :ok
  end

  def show
    render json: @owner, status: :ok
  end

  def create
    owner = Owner.new(owner_params)

    if owner.save
      render json: owner, status: :created
    else
      render json: owner.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    if @owner.update(owner_params)
      render json: @owner, status: :ok
    else
      render json: @owner.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @owner.destroy
      render json: nil, status: :ok
    else
      render json: @owner.errors, status: :unprocessable_entity
    end
  end

  private

  def set_owner
    @owner = Owner.find(params[:id])
  end

  def owner_params
    params.permit(:first_name, :last_name, :contact_information, :user_id)
  end
end