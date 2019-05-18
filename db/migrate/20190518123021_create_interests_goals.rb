class CreateInterestsGoals < ActiveRecord::Migration[5.1]
  def change
    create_table :interests_goals do |t|
      t.references :goal, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
