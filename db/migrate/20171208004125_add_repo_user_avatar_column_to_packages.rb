class AddRepoUserAvatarColumnToPackages < ActiveRecord::Migration[5.1]
  def change
    add_column :packages, :repo_user_avatar, :string
  end
end
