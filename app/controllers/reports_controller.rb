class ReportsController < ApplicationController
  before_action :set_report, only: %i[ show destroy ]

  # GET /reports or /reports.json
  def index
    @reports = current_admin.reports
  end

  # GET /reports/1 or /reports/1.json
  def show
    if @report.nil?
      @reports = current_admin.reports
      flash.now[:alert] = I18n.t("reports.errors.not_found")
      render :index
    end
  end

  # DELETE /reports/1 or /reports/1.json
  def destroy
    @report.destroy!

    respond_to do |format|
      format.html { redirect_to reports_path, status: :see_other, notice: I18n.t("reports.destroyed") }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_report
    @report = Report.find_by_id(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def report_params
    params.require(:report).permit(:user_admin_id, :collection_id, :grouping_id)
  end
end
