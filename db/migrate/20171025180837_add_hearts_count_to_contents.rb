class AddHeartsCountToContents < ActiveRecord::Migration[5.1]
  def change
    add_column :contents, :hearts_count, :integer, default: 0
  end
end
