class User::Participant < ApplicationRecord
  belongs_to :group

  validates :first_name, :last_name, :birth_date, presence: true
end
