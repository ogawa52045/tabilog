class Public::ReviewsController < ApplicationController
  before_action :set_destination, only: [:new, :create]
  before_action :is_matching_login_member, only: [:edit, :update, :destroy]
  
  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.destination = @destination

    if @review.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def set_destination
    @destination = Destination.find(params[:destination_id])
  end

  def review_params
    params.require(:review).permit(:member_id, :post_id, :star, :review_comment).merge(destination_id: @destination.id)
  end
end
