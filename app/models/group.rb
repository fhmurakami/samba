class Group < ApplicationRecord
  belongs_to :user_admin, class_name: "User::Admin", dependent: :destroy
  has_and_belongs_to_many :user_participants, class_name: "User::Participant", association_foreign_key: :user_participant_id, inverse_of: :user_participant
  # Rever associação
end
