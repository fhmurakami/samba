class ParticipantCollectionSession < ApplicationRecord
  belongs_to :collection
  belongs_to :participant, class_name: "User::Participant", foreign_key: "user_participant_id"
end
