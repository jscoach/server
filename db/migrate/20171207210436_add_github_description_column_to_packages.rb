class AddGithubDescriptionColumnToPackages < ActiveRecord::Migration[5.1]
  def change
    add_column :packages, :github_description, :string
  end
end
