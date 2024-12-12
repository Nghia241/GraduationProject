class TicketsController < ApplicationController
  before_action :authenticate_user!

  def new
    @event = Event.find(params[:event_id])
    @ticket = @event.tickets.new
  end

  def create
    @event = Event.find(params[:ticket][:event_id])
    @ticket = @event.tickets.new(ticket_params)
    @ticket.user = current_user
    if @ticket.save
      redirect_to root_path, notice: "Nhân viên đã được thêm vào sự kiện."
    else
      render :new, alert: "Đã xảy ra lỗi."
    end
  end

  private

  def ticket_params
    params.require(:ticket).permit(:qr_code_value, :event_role, :event_id)
  end
end
