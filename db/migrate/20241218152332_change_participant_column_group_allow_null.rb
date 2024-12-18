class ChangeParticipantColumnGroupAllowNull < ActiveRecord::Migration[7.2]
  def change
    change_column_null :user_participants, :group_id, true
  end
end
