class CreateContentConstellations < ActiveRecord::Migration[5.1]
  def change
    create_table :content_constellations do |t|
      t.references :content, index: true, foreign_key: true
      t.references :constellation, index: true, foreign_key: true
      t.timestamps
    end
  end
end
