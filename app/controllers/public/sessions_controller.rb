# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  def after_sign_in_path_for(resource)
    member_path(current_member.id)
  end


  def guest_sign_in
    member = Member.guest
    sign_in member
    flash[:notice] = "ゲストユーザーとしてログインしました"
    redirect_to root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
  
  private
  def member_state
    @member = Member.find_by(email: params[:member][:email])
    return if !@member
    if @member.valid_password?(params[:member][:password])
      if @member.is_deleted
        redirect_to new_member_registration_path
      else
        create
      end
    end
  end
end
