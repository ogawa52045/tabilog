class Public::PostFavoritesController < ApplicationController
 def create
    post = Post.find(params[:post_id])
    if current_member.nil?
      redirect_to login_path, alert: "ログインしてください"
    else
      favorite = current_member.favorites.new(post_id: post.id)
      favorite.save
      redirect_to post_path(post)
    end
 end

 def destroy
    post = Post.find(params[:post_id])
    if current_member.nil?
      redirect_to login_path, alert: "ログインしてください"
    else
      favorite = current_member.favorites.find_by(post_id: post.id)
      favorite.destroy
      redirect_to post_path(post)
    end
 end

end
