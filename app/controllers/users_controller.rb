class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin_user, only: [:update_role]

  # Hiển thị danh sách người dùng
  def role_manager
    # Lấy danh sách người dùng, loại bỏ current_user và sử dụng phân trang
    @users = User.includes(:system_role)
                 .where.not(id: current_user.id) # Loại bỏ current_user
                 .page(params[:page])           # Thêm phân trang
                 .per(10)                       # Số lượng người dùng mỗi trang
    @roles = SystemRole.all.where.not(role_name: "super admin")
  end

  # Cập nhật quyền người dùng
  def update_role
    user = User.find(params[:id])
    if user.update(system_role_id: params[:role_id].to_i)
      render json: { message: "Cập nhật quyền thành công!", role_name: user.system_role.role_name }, status: :ok
    else
      render json: { message: "Không thể cập nhật quyền. Vui lòng thử lại." }, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    render json: { message: "Xóa người dùng thành công!" }, status: :ok
  end

  private

  # Đảm bảo chỉ admin hoặc super admin được truy cập
  def ensure_admin_user
    unless current_user.system_role&.role_name.in?(["admin", "super admin"])
      redirect_to root_path, alert: "Bạn không có quyền truy cập."
    end
  end
end
