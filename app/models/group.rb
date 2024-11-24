class Group < ApplicationRecord
  belongs_to :user_admin, class_name: "User::Admin"
  has_many :participants
end
