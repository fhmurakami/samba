class Round::SubmitAnswerService
  def initialize(current_round, answer_value)
    @answer_value = answer_value.to_i
    @current_round = current_round
    @collection = @current_round.collection
    @participant = @current_round.participant
    @equation_started_at = @current_round.equation_started_at
    @current_equation = Equation.find_by_id(@current_round.current_equation_id)
  end

  def self.call(current_round, answer_value)
    new(current_round, answer_value).call
  end

  def call
    submit_answer
  end

  private
  def submit_answer
    raise StandardError, I18n.t("errors.messages.no_current_equation") if @current_equation.nil?

    # Create an answer for the current collection equation

    answer = Answer.create!(
      participant: @participant,
      collection_equation: CollectionEquation.find_by(collection: @collection, equation: @current_equation),
      equation: @current_equation,
      round: @current_round,
      answer_value: @answer_value,
      correct_answer: correct_answer?,
      time_spent: calculate_time_spent
    )

    answer
  end

  def correct_value
    @current_equation["position_#{@current_equation.unknown_position}"].to_i
  end

  def correct_answer?
    @answer_value == correct_value
  end

  def calculate_time_spent
    # Logic to calculate time spent to solve the equation
    start_time = @equation_started_at.to_f * 1000
    end_time = Time.current.to_f * 1000
    (end_time - start_time).to_i
  end
end
