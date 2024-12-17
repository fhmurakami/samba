class Answer < ApplicationRecord
  belongs_to :participant, class_name: "User::Participant", foreign_key: :user_participant_id
  belongs_to :collection_equation
  belongs_to :round

  has_one :collection, through: :collection_equation
  has_one :equation, through: :collection_equation

  validates_presence_of :answer_value, :correct_answer, :time_spent, on: :create
  validates :answer_value, numericality: { only_integer: true }, on: :create
  validates_uniqueness_of :answer_value, scope: [
    :user_participant_id, :round_id, :collection_equation_id
  ]
end
