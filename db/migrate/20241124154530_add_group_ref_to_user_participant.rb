class AddGroupRefToUserParticipant < ActiveRecord::Migration[7.2]
  def change
    add_reference :user_participants, :group, null: false, foreign_key: true
  end
end
