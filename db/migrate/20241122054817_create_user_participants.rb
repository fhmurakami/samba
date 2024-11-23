class CreateUserParticipants < ActiveRecord::Migration[7.2]
  def change
    create_table :user_participants do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.date :birth_date, null: false
      t.references :user_admin, null: false, foreign_key: true

      t.timestamps
    end
  end
end
