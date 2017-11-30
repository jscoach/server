class AddLastFetchedColumnToPackages < ActiveRecord::Migration[5.1]
  def change
    add_column :packages, :last_fetched, :datetime
  end
end
