class CreateParticipantCollectionSessions < ActiveRecord::Migration[7.2]
  def change
    create_table :participant_collection_sessions do |t|
      t.references :collection, null: false, foreign_key: true
      t.references :user_participant, null: false, foreign_key: true
      t.datetime :started_at
      t.datetime :completed_at

      t.timestamps
    end
  end
end
