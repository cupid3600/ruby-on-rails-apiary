class ChangeCategoryToConstellation < ActiveRecord::Migration[5.1]
  def self.up
    rename_table :categories, :constellations
  end

  def self.down
    rename_table :constellations, :categories
  end
end
