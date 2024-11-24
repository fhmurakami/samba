class RemoveUserAdminReferencesFromUserParticipants < ActiveRecord::Migration[7.2]
  def change
    remove_reference :user_participants, :user_admin, null: false, foreign_key: true
  end
end
