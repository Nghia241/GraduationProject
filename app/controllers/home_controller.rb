class HomeController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_super_admin

  def index
    @super_admin_count = User.where(system_role_id: 1).count
    @admin_count = User.where(system_role_id: 2).count
    @user_count = User.where(system_role_id: 3).count
    @event_count = Event.count
    @upcoming_events_count = Event.where("start_time >= ?", Date.today).count
    @past_events_count = Event.where("start_time < ?", Date.today).count
  end

  private

  def authorize_super_admin
    unless current_user.system_role_id == 1
      flash[:alert] = "Bạn không có quyền truy cập vào trang này."
      redirect_to root_path # Hoặc trang khác mà bạn muốn chuyển hướng
    end
  end
end

