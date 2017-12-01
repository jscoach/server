# Packages that are published and available in the catalog.
# Use this page to re-evaluate published packages.
ActiveAdmin.register Package, as: "Indexed" do
  menu priority: 3

  actions :index

  config.clear_sidebar_sections!
  config.batch_actions = false

  scope :deprecated, default: true do |scope|
    scope.published.deprecated
  end

  index do
    column :name do |resource|
      link_to resource.name, sudo_package_path(resource)
    end

    column :repository do |resource|
      link_to resource.repo.to_s, resource.github_url if resource.repo.present?
    end

    column :description
    column "Release", :latest_release
    column :stars
    column "Downloads", :last_month_downloads

    column :collections do |resource|
      resource.collections.join(", ")
    end

    column :tweeted
    column :last_fetched
    column :updated_at
    column :modified_at
  end
end
