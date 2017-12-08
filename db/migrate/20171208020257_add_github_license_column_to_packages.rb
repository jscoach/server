class AddGithubLicenseColumnToPackages < ActiveRecord::Migration[5.1]
  def change
    add_column :packages, :github_license, :string
  end
end
