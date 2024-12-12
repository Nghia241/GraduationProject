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

  # Routes cho sự kiện (Event)
  resources :events do
    member do
      get :delete # Thao tác xóa sự kiện
    end
  end

  # Routes cho vé (Ticket)
  resources :tickets, only: [:new, :create]

  # Các routes khác...
end
