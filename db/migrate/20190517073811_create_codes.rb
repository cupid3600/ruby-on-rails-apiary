class CreateCodes < ActiveRecord::Migration[5.1]
  def change
    create_table :codes do |t|
      t.references :user, foreign_key: true
      t.string :code
      t.datetime :expires_at

      t.timestamps
    end
  end
end
