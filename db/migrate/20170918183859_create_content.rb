class CreateContent < ActiveRecord::Migration[5.1]
  def change
    create_table :contents do |t|
      t.string     :file, null: :false
      t.references :user, null: :false
      t.string     :type
      t.timestamps
    end
  end
end
