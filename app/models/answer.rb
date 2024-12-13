class Answer < ApplicationRecord
  belongs_to :participant, class_name: "User::Participant", foreign_key: :user_participant_id
  belongs_to :collection_equation
  belongs_to :round

  has_one :collection, through: :collection_equation
  has_one :equation, through: :collection_equation
end
