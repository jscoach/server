class AddIndexForPackageSlug < ActiveRecord::Migration[5.1]
  def change
    add_index :packages, :slug, unique: true
  end
end
