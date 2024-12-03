class EquationsController < ApplicationController
  before_action :set_equation, only: %i[ show edit update destroy ]

  # GET /equations or /equations.json
  def index
    @equations = current_admin.equations
  end

  # GET /equations/1 or /equations/1.json
  def show
  end

  # GET /equations/new
  def new
    @equation = Equation.new
  end

  # GET /equations/1/edit
  def edit
  end

  # POST /equations or /equations.json
  def create
    @equation = Equation.new(equation_params)

    respond_to do |format|
      begin
        if @equation.save
          format.html { redirect_to @equation, notice: t("equations.created") }
          format.json { render :show, status: :created, location: @equation }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @equation.errors, status: :unprocessable_entity }
        end
      rescue ActiveRecord::RecordInvalid => invalid
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: invalid.record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /equations/1 or /equations/1.json
  def update
    respond_to do |format|
      begin
        if @equation.update(equation_params)
          format.html { redirect_to @equation, notice: t("equations.updated") }
          format.json { render :show, status: :ok, location: @equation }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @equation.errors, status: :unprocessable_entity }
        end
      rescue ActiveRecord::RecordInvalid => invalid
        invalid.record.errors.each do |error|
          @equation.errors.add(error.attribute, error.message)
        end
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @equation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /equations/1 or /equations/1.json
  def destroy
    @equation.destroy!

    respond_to do |format|
      format.html { redirect_to equations_path, status: :see_other, notice: t("equations.destroyed") }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_equation
    @equation = Equation.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def equation_params
    params.require(:equation).permit(:position_a, :position_b, :position_c, :operator, :unknown_position, :user_admin_id, collection_ids: [])
  end
end
