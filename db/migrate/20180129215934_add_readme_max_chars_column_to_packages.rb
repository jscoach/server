class AddReadmeMaxCharsColumnToPackages < ActiveRecord::Migration[5.1]
  def change
    add_column :packages, :readme_max_chars, :integer
  end
end
