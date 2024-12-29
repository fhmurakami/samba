class Round::FinishService
  def initialize(round, collection, participant, admin)
    @current_round = round
    @collection = collection
    @participant = participant
    @user_admin = admin
  end
  def self.call(round:, collection:, participant:, admin:)
    new(round, collection, participant, admin).call
  end

  def call
    # Check if all equations have been answered
    if collection_completed?
      finalize_round
    end
  end

  private

  def collection_completed?
    @collection.collection_equations.count ==
      @collection.collection_equations
        .joins(:answers)
        .where(answers: { participant: @participant, round: @current_round })
        .count
  end

  def finalize_round
    @completed_at = Time.current

    report = Report::CreateService.call(
      user_admin: @user_admin,
      collection: @collection,
      grouping: @participant.grouping,
    )

    @current_round.update!(
      completed_at: @completed_at,
      round_time: calculate_round_time,
      report: report
    )
  end

  def calculate_round_time
    # Logic to calculate time spent on the entire round
    start_time = @current_round.started_at.to_f * 1000
    end_time = @completed_at.to_f * 1000

    (end_time - start_time).to_i
  end
end
