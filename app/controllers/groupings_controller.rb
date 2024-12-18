class GroupingsController < ApplicationController
  before_action :set_grouping, only: %i[ show edit update destroy remove_participant ]

  # GET /groupings or /groupings.json
  def index
    @groupings = current_admin.groupings
  end

  # GET /groupings/1 or /groupings/1.json
  def show
  end

  # GET /groupings/new
  def new
    @grouping = Grouping.new
  end

  # GET /groupings/1/edit
  def edit
  end

  # POST /groupings or /groupings.json
  def create
    @grouping = Grouping.new(grouping_params)

    respond_to do |format|
      if @grouping.save
        format.html { redirect_to @grouping, notice: t("groupings.created") }
        format.json { render :show, status: :created, location: @grouping }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @grouping.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groupings/1 or /groupings/1.json
  def update
    respond_to do |format|
      if @grouping.update(grouping_params)
        format.html { redirect_to @grouping, notice: t("groupings.updated") }
        format.json { render :show, status: :ok, location: @grouping }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @grouping.errors, status: :unprocessable_entity }
      end
    end
  end

  def remove_participant
    @grouping.remove_participant(participant)
    redirect_to @grouping
  end

  # DELETE /groupings/1 or /groupings/1.json
  def destroy
    @grouping.destroy!

    respond_to do |format|
      format.html { redirect_to groupings_path, status: :see_other, notice: t("groupings.destroyed") }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_grouping
    @grouping ||= Grouping.find(params[:id])
  end

  def participant
    @participant ||= User::Participant.find(params[:participant_id])
  end

  # Only allow a list of trusted parameters through.
  def grouping_params
    params.require(:grouping).permit(:name, :user_admin_id)
  end
end
