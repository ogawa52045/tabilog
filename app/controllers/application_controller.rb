class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_admin!, if: :admin_url 
  
  def admin_url
    request.fullpath.include?("/admin")
  end
  
  def after_sign_in_path_for(resource)
   if resource.admin?
    # 管理者の場合はroot_pathに遷移
     root_path
   else
    # 一般ユーザーの場合はユーザーマイページに遷移
     member_path(current_member.id)
   end
  end
  
  def after_sign_out_path_for(resource)
    top_path
  end
  
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
  
end
