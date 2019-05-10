class AddIsDeletedToConstellations < ActiveRecord::Migration[5.1]
  def change
    add_column :constellations, :is_deleted, :boolean, default: false
  end
end
