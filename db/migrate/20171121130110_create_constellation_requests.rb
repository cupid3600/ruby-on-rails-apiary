class CreateConstellationRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :constellation_requests do |t|
      t.string :reason
      t.string :name
      t.integer :status, default: 0
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
