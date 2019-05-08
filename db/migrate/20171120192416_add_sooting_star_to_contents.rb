class AddSootingStarToContents < ActiveRecord::Migration[5.1]
  def change
    add_column :contents, :shooting_star, :boolean, default: false

    add_index :contents, :shooting_star, where: 'shooting_star = true'
  end
end
