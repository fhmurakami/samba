class ChangeRoundColumnReportToAllowNull < ActiveRecord::Migration[7.2]
  def change
    change_column_null :rounds, :report_id, true
  end
end
