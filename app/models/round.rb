class Round < ApplicationRecord
  belongs_to :collection
  belongs_to :participant, class_name: "User::Participant", foreign_key: "user_participant_id"
  belongs_to :report

  has_many :answers

  validates :user_participant_id, uniqueness: { scope: :collection_id }
end
