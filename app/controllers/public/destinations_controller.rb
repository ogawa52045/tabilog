class Public::DestinationsController < ApplicationController
  before_action :set_post, only: [:new, :create, :edit, :update, :show, :index]
  
  def new
    @destination = @post.build_destination
    @review = Review.new
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
    @post = Post.find(params[:id])
    if destination_blank?(post_params)
      post_params[:destination_attributes].merge!(_destroy: "1")
    end
    if @post.update(post_params)
      redirect_to @post
    else
      render :edit
    end
  end

  
  def show
    @destination = @post.destination
    @reviews = @destination.reviews
  end
  
  def index
    @destinations = Destination.all
  end
  
  
  private
  
  def set_post
    @post = Post.find(params[:post_id])
  end
  
  def destination_params
    params.require(:destination).permit(:departure_date, :return_date, :domestic_or_international, :country, :prefecture, :city, :landmark)
  end
  
end
