class AddRoundRefToAnswers < ActiveRecord::Migration[7.2]
  def change
    add_reference :answers, :round, null: false, foreign_key: true
  end
end
