class ProfilesController < ApplicationController
  before_action :authenticate_user!

  # Hiển thị thông tin cá nhân
  def show
    @user = current_user
  end

  # Cập nhật thông tin cá nhân
  def update
    @user = current_user
    if @user.update(profile_params)
      flash[:notice] = "Cập nhật thông tin cá nhân thành công!"
      redirect_to profile_path
    else
      flash[:alert] = "Có lỗi xảy ra khi cập nhật thông tin cá nhân."
      render :show
    end
  end

  # Hiển thị form đổi mật khẩu
  def edit_password
    @user = current_user
  end

  # Xử lý cập nhật mật khẩu
  def update_password
    @user = current_user
    if @user.update_with_password(password_params)
      bypass_sign_in(@user) # Đăng nhập lại sau khi đổi mật khẩu
      flash[:notice] = "Cập nhật mật khẩu thành công!"
      redirect_to profile_path
    else
      flash[:alert] = "Có lỗi xảy ra khi cập nhật mật khẩu."
      render :edit_password
    end
  end

  private

  # Strong parameters cho thông tin cá nhân
  def profile_params
    params.require(:user).permit(:name, :email, :language_id)
  end

  # Strong parameters cho mật khẩu
  def password_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end
end
