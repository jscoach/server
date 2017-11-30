class AddPositionColumnToCollections < ActiveRecord::Migration[5.1]
  def change
    add_column :collections, :position, :integer
  end
end
