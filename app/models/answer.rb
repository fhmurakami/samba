class Answer < ApplicationRecord
  belongs_to :participant, class_name: "User::Participant", foreign_key: :user_participant_id
  belongs_to :collection_equation
  belongs_to :round

  has_one :collection, through: :collection_equation
  has_one :equation, through: :collection_equation

  validates_presence_of :answer_value, :time_spent, on: :create
  validates_inclusion_of :correct_answer, in: [ true, false ], on: :create
  validates :answer_value, numericality: { only_integer: true }, on: :create
  validates_uniqueness_of :answer_value, scope: [
    :user_participant_id, :round_id, :collection_equation_id
  ]
  validates :time_spent,
             presence: true,
             numericality: {
               greater_than_or_equal_to: 0,
               only_integer: true
             }

  def formatted_time
    total_seconds = time_spent / 1000.0
    minutes = (total_seconds / 60).floor
    seconds = (total_seconds % 60).round(2)

    if minutes > 0
      "#{
        I18n.t('datetime.distance_in_words.x_minutes', count: minutes)
      } #{
        I18n.t('datetime.distance_in_words.x_seconds', count: seconds)
      }"
    else
      "#{I18n.t('datetime.distance_in_words.x_seconds', count: seconds)}"
    end
  end
end
