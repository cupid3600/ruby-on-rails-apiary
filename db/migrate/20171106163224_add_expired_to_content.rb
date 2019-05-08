class AddExpiredToContent < ActiveRecord::Migration[5.1]
  def change
    add_column :contents, :expired, :boolean, default: false
  end
end
