class User::ParticipantsController < ApplicationController
  before_action :set_participant, only: %i[ show edit update destroy ]

  # GET /user/participants or /user/participants.json
  def index
    # @user_participants = User::Participant.all
    @user_participants = current_admin.participants
  end

  # GET /user/participants/1 or /user/participants/1.json
  def show
  end

  # GET /user/participants/new
  def new
    @user_participant = User::Participant.new
  end

  # GET /user/participants/1/edit
  def edit
  end

  # POST /user/participants or /user/participants.json
  def create
    @user_participant = User::Participant.new(participant_params)

    respond_to do |format|
      if @user_participant.save
        format.html { redirect_to @user_participant, notice: t("participants.created") }
        format.json { render :show, status: :created, location: @user_participant }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user_participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user/participants/1 or /user/participants/1.json
  def update
    respond_to do |format|
      if @user_participant.update(participant_params)
        format.html { redirect_to @user_participant, notice: t("participants.updated") }
        format.json { render :show, status: :ok, location: @user_participant }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user_participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user/participants/1 or /user/participants/1.json
  def destroy
    @user_participant.destroy!

    respond_to do |format|
      format.html { redirect_to participants_path, status: :see_other, notice: t("participants.destroyed") }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_participant
    @user_participant = User::Participant.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def participant_params
    params.require(:participant).permit(:first_name, :last_name, :birth_date, :user_admin_id, :group_id)
  end
end
