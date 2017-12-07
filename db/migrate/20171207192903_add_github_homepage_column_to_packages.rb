class AddGithubHomepageColumnToPackages < ActiveRecord::Migration[5.1]
  def change
    add_column :packages, :github_homepage, :string
  end
end
