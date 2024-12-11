class CreateRounds < ActiveRecord::Migration[7.2]
  def change
    create_table :rounds do |t|
      t.references :collection, null: false, foreign_key: true
      t.references :user_participant, null: false, foreign_key: true
      t.references :current_equation, foreign_key: { to_table: :equations }
      t.datetime :started_at
      t.datetime :completed_at
      t.datetime :equation_started_at
      t.integer :round_time

      t.timestamps
    end
  end
end
