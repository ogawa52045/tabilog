class Public::PostsController < ApplicationController
  before_action :is_matching_login_member, only: [:edit, :update]
  def new
    @post = Post.new
    @post.build_destination
    puts @post.destination.inspect
  end
  
  def create
   @post = Post.new(post_params)
   Rails.logger.debug "Post params: #{post_params}"
   Rails.logger.debug "Post object: #{@post.inspect}"

   @post.member_id = current_member.id
   if @post.save
    redirect_to posts_path
   else
    render :new
   end
  end

  def index
    @posts = Post.all.order(created_at: :desc).includes(:destination)
    @destinations = Destination.all
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @destination = @post.destination
  end

  def edit
    @post = Post.find(params[:id])
    @post.build_destination unless @post.destination
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post
    else
      puts @post.errors.full_messages
      render :edit
    end
  end
  
  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to '/posts'
  end
  
  private
  def post_params
    params.require(:post).permit(:title, :content, :image, destination_attributes: [:id,:departure_date, :return_date, :domestic_or_international, :country, :prefecture, :city, :landmark])
  end
  
  def is_matching_login_member
   post = Post.find(params[:id])
   if post.member.blank?
     redirect_to posts_path, alert: '関連する会員が存在しません。'
     return
   end
   unless post.member.id == current_member.id
     redirect_to posts_path
   end
  end
  
  def destination_blank?(params)
    params[:destination_attributes].present? &&
    params[:destination_attributes].values.all?(&:blank?)
  end
end
