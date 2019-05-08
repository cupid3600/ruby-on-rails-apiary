class AddContentsCountToConstellation < ActiveRecord::Migration[5.1]
  def change
    add_column :constellations, :contents_count, :integer, default: 0
  end
end
