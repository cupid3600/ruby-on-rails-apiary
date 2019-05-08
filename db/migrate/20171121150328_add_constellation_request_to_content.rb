class AddConstellationRequestToContent < ActiveRecord::Migration[5.1]
  def change
    add_reference :contents, :constellation_request, foreign_key: true
  end
end
