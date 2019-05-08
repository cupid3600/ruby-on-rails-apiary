class ChangeUserFields < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :first_name, :string
    remove_column :users, :last_name, :string
    remove_column :users, :username, :string
    add_column :users, :full_name, :string
  end
end
