class AddBlockToContent < ActiveRecord::Migration[5.1]
  def change
    add_column :contents, :disable, :boolean, default: false
  end
end
