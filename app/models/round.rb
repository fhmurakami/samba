class Round < ApplicationRecord
  belongs_to :collection
  belongs_to :participant, class_name: "User::Participant", foreign_key: "user_participant_id"
  belongs_to :report, optional: true

  has_many :answers

  validates :user_participant_id, uniqueness: { scope: :collection_id }
  validate :rounds_length

  private

  def rounds_length
    report = Report.find_by(collection: collection)
    grouping = report&.grouping

    if report && grouping
      rounds = report&.rounds
      participants = grouping&.participants

      if rounds && participants
        return true if rounds.length <= participants.length

        errors.add(
          :base,
          :too_many_rounds,
          grouping: grouping.name,
          count: grouping.participants.length
        )
      end
    end
  end
end
