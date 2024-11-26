class Collection < ApplicationRecord
  belongs_to :user_admin, class_name: "User::Admin"

  validates :name, :equations_quantity, presence: true
end
