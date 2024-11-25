module User
  class Participant < ApplicationRecord
    belongs_to :user_admin, class_name: "User::Admin"
    has_and_belongs_to_many :groups, foreign_key: :user_participant_id, inverse_of: :user_participant
    # has_many :user_admins, through: :groups

    validates :first_name, :last_name, :birth_date, presence: true
  end
end
