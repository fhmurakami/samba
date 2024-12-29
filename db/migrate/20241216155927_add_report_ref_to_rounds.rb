class AddReportRefToRounds < ActiveRecord::Migration[7.2]
  def change
    add_reference :rounds, :report, null: false, foreign_key: true
  end
end
