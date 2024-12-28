class RoundsController < ApplicationController
  before_action :set_collection, only: %i[
    start submit_answer finish
  ]
  before_action :set_participant, only: %i[
    start submit_answer finish
  ]
  before_action :set_round, only: %i[ submit_answer finish ]

  def new
  end

  def start
    # Create service with the minimal required information
    @current_round = Round::StartService.call(@collection, @participant)

    # Get the first equation
    @current_equation = Round::NextEquationService.call(@current_round)

    if @current_equation.nil?
      redirect_to action: :finish,
        collection_id: @collection.id,
        participant_id: @participant.id,
        round_id: @current_round.id
    else
      render :start
    end
  end

  def submit_answer
    Round::SubmitAnswerService.call(@current_round, params[:answer_value])

    # Get next equation or finalize the round
    @current_equation = Round::NextEquationService.call(@current_round)
    if @current_equation.nil?
      redirect_to action: :finish,
        collection_id: @collection.id,
        participant_id: @participant.id,
        round_id: @current_round.id
    else
      render :start
    end
  end

  def finish
    Round::FinishService.call(
      round: @current_round,
      collection: @collection,
      participant: @participant,
      admin: current_admin
    )
  end

  private

  def set_collection
    @collection ||= Collection.find(params[:collection_id])
  end

  # Finds and returns the participant associated with the given participant_id parameter.
  def set_participant
    @participant ||= current_admin.participants.find(params[:participant_id])
  end

  def set_round
    @current_round ||= Round.find_by(
      collection: @collection,
      participant: @participant,
      completed_at: nil
    )
  end

  # Only allow a list of trusted parameters through.
  def round_params
    params.require(:round).permit(:answer_value, :round_id, :collection_id, :participant_id)
  end
end
