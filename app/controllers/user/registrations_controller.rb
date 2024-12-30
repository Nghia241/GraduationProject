class User::RegistrationsController < Devise::RegistrationsController
  # Ghi đè các phương thức của Devise nếu cần

  protected

  def sign_up_params
    params.require(:user).permit(:name, :email, :system_role_id, :password, :password_confirmation)
  end

  # Ghi đè phương thức after_sign_up_path_for để chuyển hướng đến trang đăng nhập
  def after_sign_up_path_for(resource)
    flash[:notice] = "Đăng ký thành công! Vui lòng đăng nhập để tiếp tục."
    sign_out(resource)
    new_user_session_path
  end
  def account_update_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
  end
end

