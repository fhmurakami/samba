class Report < ApplicationRecord
  belongs_to :user_admin, class_name: "User::Admin", foreign_key: "user_admin_id"
  belongs_to :collection
  belongs_to :grouping

  has_many :participants, class_name: "User::Participant",
    foreign_key: :user_participant_id, through: :grouping
  has_many :rounds

  validate :rounds_length

  private

  def rounds_length
    if rounds.length > grouping.participants.length
      errors.add(
        :base,
        :too_many_rounds,
        grouping: grouping.name,
        count: grouping.participants.length
      )
    end
  end
end
