class User::PasswordsController < Devise::PasswordsController
  before_action :configure_reset_password_params, only: [:create]

  # GET /user/password/new
  def new
    super
  end

  # POST /user/password
  def create
    super do |resource|
      # Logic tùy chỉnh, ví dụ:
      # Ghi log hoặc thông báo cho admin khi người dùng yêu cầu quên mật khẩu
      Rails.logger.info("Password reset requested for email: #{params[:user][:email]}")
    end
  end

  # GET /user/password/edit?reset_password_token=abcdef
  def edit
    super
  end

  # PUT /user/password
  def update
    super do |resource|
      # Logic tùy chỉnh sau khi người dùng đặt lại mật khẩu thành công
      if resource.errors.empty?
        flash[:notice] = "Your password has been reset successfully!"
      end
    end
  end

  # Tùy chỉnh tham số đặt lại mật khẩu
  protected

  def configure_reset_password_params
    devise_parameter_sanitizer.permit(:reset_password, keys: [:email])
  end

  # Đường dẫn sau khi reset mật khẩu thành công
  def after_resetting_password_path_for(resource)
    new_user_session_path # Chuyển hướng về trang đăng nhập
  end

  # Đường dẫn nếu reset mật khẩu thất bại
  def after_sending_reset_password_instructions_path_for(resource_name)
    new_user_session_path # Chuyển hướng về trang đăng nhập
  end
end
