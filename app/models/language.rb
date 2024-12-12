class Language < ApplicationRecord
  has_many :users

  validates :locale, presence: true, uniqueness: true
end
