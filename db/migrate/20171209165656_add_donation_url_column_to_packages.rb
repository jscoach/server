class AddDonationUrlColumnToPackages < ActiveRecord::Migration[5.1]
  def change
    add_column :packages, :donation_url, :string
  end
end
