class AddCustomRepoPathColumnToPackages < ActiveRecord::Migration[5.1]
  def change
    add_column :packages, :custom_repo_path, :string
  end
end
