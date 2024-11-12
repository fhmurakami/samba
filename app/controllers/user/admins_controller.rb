class User::AdminsController < ApplicationController
  before_action :set_user_admin, only: %i[ show edit update destroy ]

  # GET /user/admins or /user/admins.json
  def index
    @user_admins = User::Admin.all
  end

  # GET /user/admins/1 or /user/admins/1.json
  def show
  end

  # GET /user/admins/new
  def new
    @user_admin = User::Admin.new
  end

  # GET /user/admins/1/edit
  def edit
  end

  # POST /user/admins or /user/admins.json
  def create
    @user_admin = User::Admin.new(user_admin_params)

    respond_to do |format|
      if @user_admin.save
        format.html { redirect_to @user_admin, notice: "Admin was successfully created." }
        format.json { render :show, status: :created, location: @user_admin }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user_admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user/admins/1 or /user/admins/1.json
  def update
    respond_to do |format|
      if @user_admin.update(user_admin_params)
        format.html { redirect_to @user_admin, notice: "Admin was successfully updated." }
        format.json { render :show, status: :ok, location: @user_admin }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user_admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user/admins/1 or /user/admins/1.json
  def destroy
    @user_admin.destroy!

    respond_to do |format|
      format.html { redirect_to user_admins_path, status: :see_other, notice: "Admin was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_admin
      @user_admin = User::Admin.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_admin_params
      params.fetch(:user_admin, {})
    end
end
