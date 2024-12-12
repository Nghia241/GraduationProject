class Event < ApplicationRecord
  has_many :tickets
  has_many :users, through: :tickets

  validates :name, :location, presence: true
end
