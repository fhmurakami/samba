class ParticipantCollectionSessionService
  attr_reader :collection, :participant, :current_collection_equation

  def initialize(collection, participant)
    @collection = collection
    @participant = participant
    @current_collection_equation = nil
  end

  def start_session
    # Create a participant collection session record
    @participant_collection_session = ParticipantCollectionSession.create!(
      collection: @collection,
      participant: @participant,
      started_at: Time.current
    )
  end

  def next_equation
    # Find the next unanswered equation in the collection
    unanswered_equations = @collection.collection_equations
      .left_joins(:answers)
      .where(answers: { id: nil })
      .order(:id)

    @current_collection_equation = unanswered_equations.first

    raise StandardError, t("errors.messages.no_unanswered_equations") if @current_collection_equation.nil?

    @current_collection_equation
  end

  def submit_answer(params)
    raise StandardError, t("errors.messages.no_current_equation") if @current_collection_equation.nil?

    # Create an answer for the current collection equation
    answer = Answer.create!(
      participant: @participant,
      collection_equation: @current_collection_equation,
      equation: @current_collection_equation.equation,
      answer_value: params[:answer_value],
      correct_answer: params[:correct_answer],
      time_spent: calculate_time_spent
    )

    # Check if all equations have been answered
    if collection_completed?
      finalize_session
    end

    answer
  end
end
