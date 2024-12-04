class Answer < ApplicationRecord
  belongs_to :participant, class_name: "User::Participant", foreign_key: :user_participant_id
  belongs_to :equation
end
