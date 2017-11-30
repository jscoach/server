class AddWhitelistedColumnToPackages < ActiveRecord::Migration[5.1]
  def change
    add_column :packages, :whitelisted, :boolean, default: false
  end
end
