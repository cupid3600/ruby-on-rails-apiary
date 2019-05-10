class AddShowOnSignUpToConstellations < ActiveRecord::Migration[5.1]
  def change
    add_column :constellations, :show_on_sign_up, :boolean, default: false
  end
end
