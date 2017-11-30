class AddCollectionAndPositionColumnsToCategories < ActiveRecord::Migration[5.1]
  def change
    add_reference :categories, :collection, index: true, foreign_key: true, null: false
    add_column :categories, :position, :integer
  end
end
