class User::SessionsController < Devise::SessionsController
  # Ghi đè phương thức create để xử lý đăng nhập
  def create
    # Xác thực thông tin đăng nhập
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)

    # Thêm logic xử lý sau khi đăng nhập thành công
    respond_to do |format|
      format.html { redirect_to after_sign_in_path_for(resource) } # Chuyển hướng theo logic sau khi đăng nhập
      format.json { render json: { message: "Đăng nhập thành công", user: resource }, status: :ok }
    end
  end

  # Ghi đè phương thức destroy để xử lý đăng xuất
  def destroy
    # Đăng xuất tài khoản
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message! :notice, :signed_out if signed_out

    # Thêm logic sau khi đăng xuất
    respond_to do |format|
      format.html { redirect_to after_sign_out_path_for(resource_name) } # Chuyển hướng đến trang đăng nhập
      format.json { render json: { message: "Đăng xuất thành công" }, status: :ok }
    end
  end

  # Ghi đè phương thức after_sign_in_path_for để chuyển hướng sau đăng nhập
  protected

  def after_sign_in_path_for(resource)
    # Chuyển hướng đến trang dashboard hoặc trang chính (mặc định: home_index_path)
    stored_location_for(resource) || home_index_path
  end

  # Ghi đè phương thức after_sign_out_path_for để chuyển hướng sau đăng xuất
  def after_sign_out_path_for(resource_or_scope)
    # Chuyển hướng đến trang đăng nhập sau khi đăng xuất
    new_user_session_path
  end
end
