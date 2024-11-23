class User::Participant < ApplicationRecord
  belongs_to :user_admin, class_name: "User::Admin"

  validates :first_name, :last_name, :birth_date, presence: true
end
