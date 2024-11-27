class Group < ApplicationRecord
  belongs_to :user_admin, class_name: "User::Admin", dependent: :destroy
  has_and_belongs_to_many :participants, class_name: "User::Participant", association_foreign_key: :user_participant_id

  def remove_participant(participant)
    participants.delete(participant)
  end
end
