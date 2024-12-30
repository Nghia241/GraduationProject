class User::RegistrationsController < Devise::RegistrationsController
  # Ghi đè các phương thức của Devise nếu cần
  def create
    super do |resource|
      if resource.persisted? # Kiểm tra xem tài khoản đã được tạo thành công
        sign_out(resource) # Xóa session để người dùng không đăng nhập tự động
        flash[:notice] = "Đăng ký thành công! Vui lòng đăng nhập để tiếp tục."
        redirect_to new_user_session_path and return # Chuyển hướng đến trang đăng nhập
      end
    end
  end

  protected

  def sign_up_params
    params.require(:user).permit(:name, :email, :system_role_id, :password, :password_confirmation)
  end

  # Ghi đè phương thức after_sign_up_path_for để chuyển hướng đến trang đăng nhập
  def after_sign_up_path_for(resource)
    flash[:notice] = "Đăng ký thành công! Vui lòng đăng nhập để tiếp tục."
    new_user_session_path
  end
  def account_update_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
  end
end

