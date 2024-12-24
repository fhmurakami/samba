class Round::StartService
  attr_reader :collection, :participant, :current_collection_equation

  def initialize(collection, participant)
    @collection = collection
    @participant = participant
  end

  def self.call(collection, participant)
    new(collection, participant).call
  end

  def call
    start_round
  end

  private

  def start_round
    # Find or Create a participant collection round record
    @round = Round.find_or_create_by(
      collection: @collection,
      participant: @participant,
      completed_at: nil,
      report: nil
    )

    if @round.started_at.nil?
      @round.started_at = Time.current
      @round.save
    end

    @round
  end
end
