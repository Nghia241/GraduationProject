Rails.application.routes.draw do
  # Cấu hình Devise cho user
  devise_for :user, controllers: {
    sessions: 'user/sessions',
    registrations: 'user/registrations',
    passwords: 'user/passwords'
  }

  # Đăng xuất
  devise_scope :user do
    delete 'logout', to: 'user/sessions#destroy', as: :logout
  end

  # Trang mặc định chuyển hướng tới trang đăng nhập
  devise_scope :user do
    root to: 'user/sessions#new' # Trang đăng nhập mặc định
  end

  # Trang HomePage sau khi đăng nhập
  get 'home/index', to: 'home#index', as: :home_index

  resources :users, only: [:index, :destroy] do
    collection do
      get :role_manager
    end
    member do
      post :update_role
    end
  end

  resource :profile, only: [:show, :update] do
    member do
      get :edit_password # Màn hình đổi mật khẩu
      patch :update_password # Xử lý cập nhật mật khẩu
    end
  end

  # Routes cho sự kiện (Event)
  resources :event do
    collection do
      get :event_details
    end
    member do
      get :employees_list
      post :add_employee_to_event
      delete :remove_employee_from_event
      get :delete # Thao tác xóa sự kiện
      get :qrcode
      get :scan_qr # Màn hình quét QR
      post :decode
      patch :change_employee_role
      post :change_role
      get :check_in_status
    end
  end

  # Routes cho vé (Ticket)
  resources :tickets, only: [:new, :create]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
