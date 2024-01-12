class Public::PostsController < ApplicationController
  before_action :is_matching_login_member, only: [:edit, :update]
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.member_id = current_member.id
    if @post.save
     redirect_to posts_path
    else
      render :new
    end
  end

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
     redirect_to @post
    else
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
    params.require(:post).permit(:title, :content, :image)
  end
  
  def is_matching_login_member
      post = Post.find(params[:id])
     unless post.member.present?
     redirect_to posts_path, alert: '関連する会員が存在しません。'
     return
     end
     unless post.member.id == current_member.id
      redirect_to posts_path
     end
  end
end
