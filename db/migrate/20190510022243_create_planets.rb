class CreatePlanets < ActiveRecord::Migration[5.1]
  def change
    create_table :planets do |t|
      t.string :title, null: false
      t.string :icon, null: true
      t.boolean :is_approved, null: false, default: false
      t.boolean :is_deleted, null: false, default: false
      t.references :constellation, foreign_key: true

      t.timestamps
    end
  end
end
