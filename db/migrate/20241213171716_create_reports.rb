class CreateReports < ActiveRecord::Migration[7.2]
  def change
    create_table :reports do |t|
      t.references :user_admin, null: false, foreign_key: true
      t.references :collection, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
