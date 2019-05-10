class CreateInterestsConstellations < ActiveRecord::Migration[5.1]
  def change
    create_table :interests_constellations do |t|
      t.references :constellation, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
