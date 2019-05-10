class CreateInterestsPlanets < ActiveRecord::Migration[5.1]
  def change
    create_table :interests_planets do |t|
      t.references :planet, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
