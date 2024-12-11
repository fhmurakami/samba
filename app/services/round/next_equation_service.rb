class Round::NextEquationService
  def initialize(current_round)
    @current_round = current_round
    @collection = @current_round.collection
    @participant = @current_round.participant
  end

  def self.call(current_round)
    new(current_round).call
  end

  def call
    next_equation
  end

  private

  def next_equation
    # Find the next unanswered equation in the collection
    current_equation = unanswered_equations.shift

    unless current_equation.nil?
      # Set the start time for the current equation
      @current_round.equation_started_at = Time.current
      @current_round.current_equation_id = current_equation.id
      @current_round.save!
    end

    current_equation
  end

  # Returns an array of equations that have not been answered by the current participant yet.
  def unanswered_equations
    @unanswered_equations ||= @collection.equations.select do |equation|
      !equation.answers.exists?(participant: @participant, round: @current_round)
    end
  end
end
