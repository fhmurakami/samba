class CollectionsController < ApplicationController
  before_action :find_equation, only: :remove_equation
  before_action :set_collection, only: %i[
    show edit update destroy remove_equation
    start_round submit_answer finish_round
  ]
  before_action :set_participant, only: %i[
    start_round submit_answer finish_round
  ]
  before_action :set_round, only: %i[ submit_answer finish_round ]

  # GET /collections or /collections.json
  def index
    @collections = current_admin.collections
  end

  # GET /collections/1 or /collections/1.json
  def show
  end

  # GET /collections/new
  def new
    @collection = Collection.new
  end

  # GET /collections/1/edit
  def edit
  end

  # POST /collections or /collections.json
  def create
    @collection = Collection.new(collection_params)

    respond_to do |format|
      if @collection.save
        format.html {
          redirect_to @collection,
          notice: t("collections.created")
        }
        format.json { render :show, status: :created, location: @collection }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json {
          render json: @collection.errors,
          status: :unprocessable_entity
        }
      end
    end
  end

  # PATCH/PUT /collections/1 or /collections/1.json
  def update
    respond_to do |format|
      if @collection.update(collection_params)
        format.html {
          redirect_to @collection,
          notice: t("collections.updated")
        }
        format.json { render :show, status: :ok, location: @collection }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json {
          render json: @collection.errors,
          status: :unprocessable_entity
        }
      end
    end
  end

  # DELETE /collections/1 or /collections/1.json
  def destroy
    @collection.destroy!

    respond_to do |format|
      format.html {
        redirect_to collections_path,
        status: :see_other,
        notice: t("collections.destroyed")
      }
      format.json { head :no_content }
    end
  end

  def remove_equation
    @collection.collection_equations.where(equation: @equation).delete_all
    @collection.equations.delete(@equation)
    redirect_to @collection
  end

  def start_round
    # Create service with the minimal required information
    @current_round = Round::StartService.call(@collection, @participant)

    # Get the first equation
    @current_equation = Round::NextEquationService.call(@current_round)

    if @current_equation.nil?
      redirect_to action: :finish_round,
        collection_id: @collection.id, participant_id: @participant.id
    else
      render :start_round
    end
  end

  def submit_answer
    Round::SubmitAnswerService.call(@current_round, params[:answer_value])

    # Get next equation or finalize the round
    @current_equation = Round::NextEquationService.call(@current_round)
    if @current_equation.nil?
      redirect_to action: :finish_round,
        collection_id: @collection.id, participant_id: @participant.id
    else
      render :start_round
    end
  end

  def finish_round
    # @current_round = Round.find_by(collection: @collection, participant: @participant, completed_at: nil)
    Round::FinishService.call(@current_round)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_collection
    if params[:collection_id]
      @collection = Collection.find(params[:collection_id])
    else
      @collection = Collection.find(params[:id])
    end
  end

  # Finds the equation with the given id
  def find_equation
    @equation ||= Equation.find(params[:equation_id])
  end

  def set_round
    @current_round ||= Round.find_by(
      collection: @collection,
      participant: @participant,
      completed_at: nil
    )
  end

  # Finds and returns the participant associated with the given participant_id parameter.
  def set_participant
    @participant ||= current_admin.participants.find(params[:participant_id])
  end

  # Only allow a list of trusted parameters through.
  def collection_params
    params.require(:collection).permit(:name, :equations_quantity, :user_admin_id)
  end
end
