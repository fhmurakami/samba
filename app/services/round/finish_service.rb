class Round::FinishService
  def initialize(current_round)
    @current_round = current_round
    @collection = @current_round.collection
    @participant = @current_round.participant
  end
  def self.call(current_round)
    new(current_round).call
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
    @current_round.update!(
      completed_at: Time.current
    )

    calculate_round_time
    Report.new(
      user_admin: current_admin,
      collection: @collection,
      grouping: @participant.grouping
    )
  end

  def calculate_round_time
    # Logic to calculate time spent on the entire round
    start_time = @current_round.started_at.to_f * 1000
    end_time = Time.current.to_f * 1000
    @current_round.round_time = (end_time - start_time).to_i
    @current_round.save
  end
end
