class Report < ApplicationRecord
  belongs_to :user_admin, class_name: "User::Admin", foreign_key: "user_admin_id"
  belongs_to :collection
  belongs_to :grouping

  has_many :participants, class_name: "User::Participant",
    foreign_key: :user_participant_id, through: :grouping
  has_many :rounds
end
