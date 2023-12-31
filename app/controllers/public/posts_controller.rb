class Public::PostsController < ApplicationController
  before_action :is_matching_login_member, only: [:edit, :update]
  def new
    @post = Post.new
  end
  
  def create
    post = Post.new(post_params)
    post.save
    redirect_to post_path(post.id)
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    post = Post.find(params[:id])
    post.update(post_params)
    redirect_to root_path
  end
  
  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to '/posts'
  end
  
  private
  def post_params
    params.require(:post).permit(:title, :content, :image)
  end
  
  def is_matching_login_member
      post = Post.find(params[:id])
     unless post.member.id == current_member.id
      redirect_to posts_path
     end
  end
end
