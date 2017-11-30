class AddHiddenColumnToPackages < ActiveRecord::Migration[5.1]
  def change
    add_column :packages, :hidden, :boolean, default: :false
  end
end
