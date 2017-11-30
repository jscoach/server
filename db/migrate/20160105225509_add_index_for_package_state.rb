class AddIndexForPackageState < ActiveRecord::Migration[5.1]
  def change
    add_index :packages, :state
  end
end
