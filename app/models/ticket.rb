class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :event

  enum event_role: { user: 0, admin: 1, organizer: 2}
  validates :qr_code_value, presence: true
end
