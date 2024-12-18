class RenameGroupTableToGrouping < ActiveRecord::Migration[7.2]
  def change
    rename_table :groups, :groupings
    rename_column :reports, :group_id, :grouping_id
    rename_column :user_participants, :group_id, :grouping_id
  end
end
