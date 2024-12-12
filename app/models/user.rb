class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Devise modules for authentication
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  belongs_to :system_role, optional: true
  belongs_to :language, optional: true

  has_many :tickets, dependent: :destroy
  has_many :events, through: :tickets

  # Active Storage (if users can upload QR codes or profile images)
  has_one_attached :qr_code

  # Validations
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :qr_code, content_type: ['image/png', 'image/jpg', 'image/jpeg'], size: { less_than: 5.megabytes }

  # Custom methods (if needed)
  def full_role_name
    system_role ? system_role.role_name : "No Role"
  end

  def tickets_for_event(event_id)
    tickets.where(event_id: event_id)
  end
end

