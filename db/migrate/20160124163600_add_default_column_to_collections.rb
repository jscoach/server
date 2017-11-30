class AddDefaultColumnToCollections < ActiveRecord::Migration[5.1]
  def change
    add_column :collections, :default, :boolean, default: :true
  end
end
