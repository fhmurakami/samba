class CreateJoinTableGroupUserParticipant < ActiveRecord::Migration[7.2]
  def change
    create_join_table :groups, :user_participants do |t|
      t.index [:group_id, :user_participant_id]
      t.index [:user_participant_id, :group_id]
    end
  end
end
