class Public::MembersController < ApplicationController
  before_action :authenticate_member!
  def edit
    @member = Member.find(params[:id])
  end
  
  def update
    @member = Member.find(params[:id])
    if @member.update(member_params)
      redirect_to member_path(@member.id), notice:"ユーザー情報を更新しました"
    else
      render :edit
    end
  end
  
  def show
    @member = Member.find(params[:id])
    @member_posts = @member.posts
  end

  def index
    @member = current_member
    @members = Member.all
  end
  
  def withdraw
    @member = Member.find(current_member.id)
    @member.update(is_deleted: true)
     reset_session
     flash[:notice] = "退会処理を実行いたしました"
   redirect_to root_path
  end
  
  private
  
  def member_params
    params.require(:member).permit(:name, :profile_image, :bio)
  end
  
  def is_matching_login_member
    @member = Member.find(params[:id])
    unless @member.id == current_member.id
      redirect_to member_path(current_member)
    end
  end
  
  def post_params
    params.require(:post).permit(:title, :image)
  end
end
