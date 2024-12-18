class Grouping < ApplicationRecord
  belongs_to :user_admin, class_name: "User::Admin", dependent: :destroy
  has_many :participants, class_name: "User::Participant"
  has_many :reports

  validates :name, presence: true

  def remove_participant(participant)
    participants.delete(participant)
  end
end
