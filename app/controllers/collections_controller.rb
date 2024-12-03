class CollectionsController < ApplicationController
  before_action :set_collection, only: %i[ show edit update destroy remove_equation ]
  before_action :equation, only: :remove_equation

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
        format.html { redirect_to @collection, notice: t("collections.created") }
        format.json { render :show, status: :created, location: @collection }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /collections/1 or /collections/1.json
  def update
    respond_to do |format|
      if @collection.update(collection_params)
        format.html { redirect_to @collection, notice: t("collections.updated") }
        format.json { render :show, status: :ok, location: @collection }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /collections/1 or /collections/1.json
  def destroy
    @collection.destroy!

    respond_to do |format|
      format.html { redirect_to collections_path, status: :see_other, notice: t("collections.destroyed") }
      format.json { head :no_content }
    end
  end

  def remove_equation
    @collection.equations.delete(@equation)
    redirect_to @collection
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_collection
    @collection = Collection.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def collection_params
    params.require(:collection).permit(:name, :equations_quantity, :user_admin_id)
  end

  # Finds the equation with the given id
  def equation
    @equation ||= Equation.find(params[:equation_id])
  end
end
