class CreateEquations < ActiveRecord::Migration[7.2]
  def change
    create_table :equations do |t|
      t.integer :position_a
      t.integer :position_b
      t.integer :position_c
      t.string :operator
      t.string :unknown_position
      t.references :user_admin, null: false, foreign_key: true

      t.timestamps
    end
  end
end
