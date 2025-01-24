class SystemRole < ApplicationRecord
  has_many :users

  validates :role_name, presence: true, uniqueness: true
  def self.ransackable_attributes(auth_object = nil)
    ["id", "role_name", "description", "created_at", "updated_at"]
  end
end
