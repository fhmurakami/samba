class CreateCollections < ActiveRecord::Migration[7.2]
  def change
    create_table :collections do |t|
      t.string :name
      t.integer :equations_quantity
      t.references :user_admin, null: false, foreign_key: true

      t.timestamps
    end
  end
end
