# Packages that are published and available in the catalog.
# Use this page to re-evaluate published packages.
ActiveAdmin.register Package, as: "Indexed" do
  menu priority: 3

  actions :index

  config.clear_sidebar_sections!
  config.batch_actions = false
  config.sort_order = "modified_at_asc"

  scope :deprecated, default: true, show_count: false do |scope|
    scope.published.deprecated
  end

  scope :maybe_deprecated, show_count: false do |scope|
    scope.published.where("readme ilike '%deprecated%'")
  end

  scope :no_description, show_count: false do |scope|
    # There are some reasons why a description may be unavailable:
    # - It was neither added by the author or reviewer
    # - It included markdown that was removed, like badges
    scope.published.algolia_search(Package::DESCRIPTION_UNAVAILABLE)
  end

  scope :unloved, show_count: false do |scope|
    scope.default.published.where("modified_at <= ?", 2.years.ago).where("stars <= ?", 1)
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
