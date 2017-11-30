class AddDependentsColumnToPackages < ActiveRecord::Migration[5.1]
  def change
    add_column :packages, :dependents, :integer
  end
end
