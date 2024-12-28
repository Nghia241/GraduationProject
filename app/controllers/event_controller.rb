require 'base64'
require 'json'

class EventController < ApplicationController
  before_action :authenticate_user!

  def index
    @events = Event.page(params[:page]).per(2)
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

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to event_path(@event), notice: "Sự kiện đã được cập nhật thành công."
    else
      render :show, alert: "Đã xảy ra lỗi khi cập nhật sự kiện."
    end
  end

  def delete
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to root_path, notice: "Sự kiện đã được xóa."
  end

  def qrcode
    @event = Event.find(params[:id])

    # Dữ liệu kết hợp: event ID và user ID
    raw_data = {
      event_id: @event.id,
      user_id: current_user.id
    }.to_json

    # Mã hóa dữ liệu bằng Base64
    encoded_data = Base64.strict_encode64(raw_data)

    # Tạo QR Code từ dữ liệu đã mã hóa
    @qrcode = RQRCode::QRCode.new(encoded_data)
  end

  def scan_qr
    @event = Event.find(params[:id])
  end

  def employees_list
    @event = Event.find(params[:id])

    # Lấy danh sách tất cả nhân viên ngoại trừ bản thân
    @q = User.ransack(params[:q])
    @employees = @q.result(distinct: true).where.not(id: current_user.id).map do |user|
      {
        id: user.id,
        name: user.name,
        has_ticket: Ticket.exists?(event_id: @event.id, user_id: user.id)
      }
    end

    # Lọc theo trạng thái tham gia sự kiện
    if params[:status] == 'participated'
      @employees.select! { |employee| employee[:has_ticket] }
    elsif params[:status] == 'not_participated'
      @employees.select! { |employee| !employee[:has_ticket] }
    end

    # Phân trang
    @paginated_employees = Kaminari.paginate_array(@employees).page(params[:page]).per(10)
  end

  def add_employee_to_event
    event = Event.find(params[:id])
    user = User.find(params[:user_id])

    raw_data = {
      event_id: event.id,
      user_id: user.id
    }.to_json

    # Mã hóa dữ liệu bằng Base64
    encoded_data = Base64.strict_encode64(raw_data)
    ticket = Ticket.create!(event: event, user: user, qr_code_value: encoded_data)

    if ticket.save
      render json: { message: "Nhân viên đã được thêm vào sự kiện thành công!" }, status: :ok
    else
      render json: { message: "Không thể thêm nhân viên vào sự kiện." }, status: :unprocessable_entity
    end
  end

  def remove_employee_from_event
    ticket = Ticket.find_by(event_id: params[:id], user_id: params[:user_id])

    if ticket&.destroy
      render json: { message: "Nhân viên đã được xóa khỏi sự kiện thành công!" }, status: :ok
    else
      render json: { message: "Không thể xóa nhân viên khỏi sự kiện." }, status: :unprocessable_entity
    end
  end

  # def decode_qrcode
  #   binding.pry
  #   # Giải mã Base64
  #   decoded_data = Base64.decode64(encoded_data)
  #
  #   # Parse JSON để lấy thông tin
  #   parsed_data = JSON.parse(decoded_data)
  #   event_id = parsed_data["event_id"]
  #   user_id = parsed_data["user_id"]
  #
  #   { event_id: event_id, user_id: user_id }
  #   binding.pry
  # end
  def decode
    encoded_data = params[:qr_data].to_s
    event_id = params[:event_id]

    begin
      # Giải mã Base64
      decoded_data = Base64.decode64(encoded_data)

      # Parse JSON để lấy thông tin
      parsed_data = JSON.parse(decoded_data)
      event_id_qr = parsed_data["event_id_qr"]
      user_id = parsed_data["user_id"]

      # Kiểm tra tính hợp lệ
      if event_id_qr == event_id && User.find_by(id: user_id).present?
        render json: { message: "QR Code hợp lệ!", event_id: event_id_qr, user_id: user_id }, status: :ok
      else
        render json: { message: "QR Code không hợp lệ hoặc không khớp với sự kiện." }, status: :unprocessable_entity
      end

    rescue JSON::ParserError => e
      # Xử lý lỗi khi JSON không hợp lệ
      render json: { error: "Dữ liệu QR Code không hợp lệ: #{e.message}" }, status: :unprocessable_entity
    rescue StandardError => e
      # Xử lý lỗi khác
      render json: { error: "Đã xảy ra lỗi trong quá trình xử lý: #{e.message}" }, status: :internal_server_error
    end
  end

  def event_params
    params.require(:event).permit(:name, :location, :start_time, :end_time, :image)
  end

  def validate_qrcode
    encoded_data = params[:qrcode_data] # Nhận chuỗi mã hóa từ QR Code
    decoded_info = decode_qrcode(encoded_data)

    event = Event.find(decoded_info[:event_id])
    user = User.find(decoded_info[:user_id])

    if event && user
      render json: { message: "QR Code hợp lệ!", event: event.name, user: user.email }
    else
      render json: { message: "QR Code không hợp lệ!" }, status: :unprocessable_entity
    end
  end

end
