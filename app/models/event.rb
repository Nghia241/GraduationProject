class Event < ApplicationRecord
  has_many :tickets
  has_many :users, through: :tickets

  validates :name, :location, presence: true
  has_one_attached :image
end
