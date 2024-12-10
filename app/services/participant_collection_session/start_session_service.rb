class ParticipantCollectionSession::StartService
  attr_reader :collection, :participant, :current_collection_equation

  def initialize(collection, participant)
    @collection = collection
    @participant = participant
    @current_collection_equation = nil
    @session_time = nil
    @equation_started_at = nil
  end

  def start_session
    # Create a participant collection session record
    @participant_collection_session = ParticipantCollectionSession.find_or_create_by!(
      collection: @collection,
      participant: @participant,
      started_at: Time.current
    )
  end

  def next_equation
    # Find the next unanswered equation in the collection
    @current_collection_equation = unanswered_equations.shift

    if @current_collection_equation.nil?
      raise StandardError, t("errors.messages.no_unanswered_equations")
    end

    # Set the start time for the current equation
    @equation_started_at = Time.current
    @current_collection_equation
  end


  def submit_answer(params)
    raise StandardError, I18n.t("errors.messages.no_current_equation") if current_equation.nil?

    # Create an answer for the current collection equation

    answer = Answer.create!(
      participant: @participant,
      collection_equation: CollectionEquation.find_by(collection: @collection, equation: current_equation),
      equation: current_equation,
      answer_value: params[:answer_value],
      correct_answer: correct_answer?(params[:answer_value], correct_value: current_equation["position_#{current_equation.unknown_position}"]),
      time_spent: calculate_time_spent(@equation_started_at)
    )

    # Check if all equations have been answered
    if collection_completed?
      finalize_session
    end

    answer
  end

  private

  # Returns an array of equations that have not been answered by the current participant yet.
  def unanswered_equations
    @unanswered_equations ||= @collection.equations.select do |equation|
      !equation.answers.exists?(participant: @participant)
    end
  end

  def current_equation
    @current_collection_equation ||= unanswered_equations.first
  end

  def correct_answer?(answer_value, correct_value)
    answer_value.to_i == correct_value
  end

  def calculate_session_time
    # Logic to calculate time spent on the entire session
    start_time = @participant_collection_session.started_at.to_f * 1000
    end_time = Time.current.to_f * 1000
    @session_time = (end_time - start_time).to_i
  end

  def calculate_time_spent(started_at)
    # Logic to calculate time spent to solve the equation
    start_time = started_at.to_f * 1000
    end_time = Time.current.to_f * 1000
    (end_time - start_time).to_i
  end

  def collection_completed?
    collection.collection_equations.count ==
      collection.collection_equations
        .joins(:answers)
        .where(answers: { participant: @participant })
        .count
  end

  def participant_session
    @participant_collection_session ||=  ParticipantCollectionSession.find_by(
      collection: @collection,
      participant: @participant
    )
  end

  def finalize_session
    @participant_collection_session.update!(
      completed_at: Time.current
    )
  end
end
