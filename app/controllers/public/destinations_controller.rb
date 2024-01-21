class Public::DestinationsController < ApplicationController
  before_action :set_post, only: [:new, :create, :edit, :update]
  
  def new
    @destination = @post.build_destination
  end
  
  def create
    @destination = @post.build_destination(destination_params)
    if @destination.save
      redirect_to @post
    else
      render :new
    end
  end
  
  def edit
    @destination = @post.destination
  end
  
  def update
    @destination = @post.destination
    if @destination.update(destination_params)
      redirect_to @post
    else
      render :edit
    end
  end
  
  private
  
  def set_post
    @post = Post.find(params[:post_id])
  end
  
  def destination_params
    params.require(:destination).permit(:departure_date, :return_date, :domestic_or_international, :country, :prefecture, :city, :landmark)
  end
  
end
