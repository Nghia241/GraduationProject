class EventsController < ApplicationController
  before_action :authenticate_user!

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to root_path, notice: "Sự kiện đã được tạo thành công."
    else
      render :new, alert: "Đã xảy ra lỗi."
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def delete
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to root_path, notice: "Sự kiện đã được xóa."
  end

  private

  def event_params
    params.require(:event).permit(:name, :location, :start_time, :end_time)
  end
end
