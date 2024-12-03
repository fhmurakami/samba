class CreateCollectionEquations < ActiveRecord::Migration[7.2]
  def change
    create_table :collection_equations do |t|
      t.references :collection, null: false, foreign_key: true
      t.references :equation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
