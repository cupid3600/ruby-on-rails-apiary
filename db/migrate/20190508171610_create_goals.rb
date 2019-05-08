class CreateGoals < ActiveRecord::Migration[5.1]
  def change
    create_table :goals do |t|
      t.string :slug, unique: true, index: true, null: false
      t.string :title, null: false
      t.boolean :is_deleted, default: false

      t.timestamps
    end
  end
end
