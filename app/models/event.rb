class Event < ApplicationRecord
  include Discard::Model
  has_many :tickets, dependent: :destroy
  has_many :users, through: :tickets

  validates :name, :location, presence: true
  has_one_attached :image

  def self.ransackable_attributes(auth_object = nil)
    ["id", "name", "location", "start_time", "end_time", "created_at", "updated_at"]
  end
end
