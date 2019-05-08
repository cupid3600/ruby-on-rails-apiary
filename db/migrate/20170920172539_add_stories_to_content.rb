class AddStoriesToContent < ActiveRecord::Migration[5.1]
  def change
    rename_column :constellations, :contents_count, :stories
  end
end
