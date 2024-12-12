class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :qr_code_value, presence: true
end
