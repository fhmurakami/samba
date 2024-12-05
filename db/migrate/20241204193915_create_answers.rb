class CreateAnswers < ActiveRecord::Migration[7.2]
  def change
    create_table :answers do |t|
      t.references :user_participant, null: false, foreign_key: true
      t.references :collection_equation, null: false, foreign_key: true
      t.integer :answer_value
      t.boolean :correct_answer
      t.integer :time_spent

      t.timestamps
    end
  end
end
