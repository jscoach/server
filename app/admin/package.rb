ActiveAdmin.register Package do
  menu priority: 1

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  permit_params :name, :repo, :description, :whitelisted, :tweeted, :custom_repo_path, collection_ids: []

  actions :index, :show, :edit, :update, :new, :create

  decorate_with PackageDecorator

  scope :pending
  scope :rejected
  scope :accepted, default: true

  config.sort_order = 'created_at_desc'

  config.enable_search = true

  controller do
    def scoped_collection
      if active_admin_config.search_enabled? and params[:search].present?
        end_of_association_chain.search(params[:search])
      else
        end_of_association_chain
      end
    end
  end

  filter :stars
  filter :hidden

  index do
    selectable_column

    column :name do |resource|
      link_to resource.name, sudo_package_path(resource)
    end

    column :repository do |resource|
      link_to resource.repo.to_s, resource.github_url if resource.repo.present?
    end

    column :custom do |resource|
      status_tag resource.repo!.present?
    end

    column :description

    column :custom do |resource|
      status_tag resource.description!.present?
    end

    column :readme do |resource|
      num_chars = resource.readme_plain_text.size
      status_tag(num_chars, num_chars >= Package::README_MIN_LENGTH ? :green : :red)
    end

    column :fork do |resource|
      status_tag resource.is_fork
    end

    column :stars

    column "Release", :latest_release
    column :modified_at
    column :last_fetched
    column :updated_at
    column :created_at
  end

  show do
    columns do
      column span: 2 do
        panel "README#{ ' (truncated)' if package.readme_was_truncated_for_algolia }", class: "readme" do
          package.readme_for_algolia.to_s.html_safe
        end
      end

      column do
        panel 'Package metadata' do
          attributes_table_for package do
            if package.published?
              row :public_link do |resource|
                link_to "js.coach/#{ resource.name }", "https://js.coach/#{ resource.name }"
              end
            end

            row :state do |resource|
              status_tag resource.state.titleize, :ok
            end

            row :collections do |resource|
              resource.collections.join(", ")
            end

            row :repository do |resource|
              link_to resource.repo.to_s, resource.github_url if resource.repo.present?
            end

            row :custom_repository do |resource|
              status_tag resource.repo!.present?
            end
            if package.repo.present? && package.custom_repo_path.present?
              row :custom_repo_path do |resource|
                link_to resource.custom_repo_path,
                  "#{ resource.github_url }/tree/master/#{ resource.custom_repo_path }"
              end
            end

            row :npm_profile do |resource|
              link_to "npmjs.com/#{ resource.name }", "https://npmjs.com/package/#{ resource.name }"
            end

            row :description
            row :custom_description do |resource|
              status_tag resource.description!.present?
            end

            row :readme do |resource|
              num_chars = resource.readme_plain_text.size
              status_tag(num_chars, num_chars >= Package::README_MIN_LENGTH ? :green : :red)
            end

            row :latest_release
            row :modified_at
            row :stars

            row "Downloads" do |resource|
              if resource.last_week_downloads and resource.last_month_downloads
                "#{ resource.last_week_downloads } last week, " +
                "#{ resource.last_month_downloads } last month"
              end
            end
          end
        end

        panel 'Other metadata' do
          attributes_table_for package do
            row :keywords do |resource|
              resource.keywords.join(", ")
            end

            row :languages do |resource|
              languages = resource.languages.to_h
              languages.map { |name, bits| "#{ name } (#{ bits })" }.join("<br>").html_safe
            end

            row :is_fork do |resource|
              status_tag resource.is_fork, :ok
            end

            row :published_at
            row :pushed_at
            row :license
            row :github_license
            row :homepage
            row :github_homepage
            row :created_at
            row :updated_at
            row :last_fetched
            row :tweeted?
            row :deprecated?

            row :contributors do |resource|
              pre { JSON.pretty_generate resource.contributors } if resource.contributors.present?
            end

            row :manifest do |resource|
              pre { JSON.pretty_generate resource.manifest } if resource.manifest.present?
            end
          end
        end
      end
    end

    if package.repo.present? && package.published?
      script do
        """
          $.ajax({
            url: 'https://raw.githubusercontent.com/#{ package.repo }/master/README.md',
            method: 'head',
            success: () => $('.row-repository td a').css('color', 'mediumseagreen'),
            statusCode: {
              404: () => $('.row-repository td a').css('color', 'orangered').parent()
                .append(' <a href=\"https://github.com/search?s=stars&q=#{ package.name }\" target=\"_blank\">(404 🔎)</a>')
            }
          });
        """.html_safe
      end
    end
  end

  form do |f|
    columns do
      column do
        if f.object.new_record?
          f.inputs "New package" do
            f.input :name
            f.input :repo
          end
        end

        unless f.object.new_record?
          f.inputs "Update #{ package.name }" do
            f.input :repo
            f.input :description, input_html: { rows: 6 }
            f.input :custom_repo_path
            f.input :whitelisted, label: "Whitelisted (relaxes validations)"
            f.input :tweeted
            f.input :collections, collection: Collection.all, as: :check_boxes
          end
        end

        f.actions
      end

      column do
      end
    end
  end

  batch_action :pending, if: proc { @current_scope.scope_method == :rejected } do |ids|
    batch_action_collection.find(ids).each do |package|
      package.pending!
    end
    redirect_back fallback_location: collection_path, alert: "The packages transitioned to pending."
  end

  batch_action :reject, if: proc { @current_scope.scope_method != :rejected } do |ids|
    batch_action_collection.find(ids).each do |package|
      package.reject!
    end
    redirect_back fallback_location: collection_path, alert: "The packages transitioned to rejected."
  end

  batch_action :toggle_visibility do |ids|
    batch_action_collection.find(ids).each do |package|
      package.hidden = !package.hidden
      package.save!
    end
    redirect_back fallback_location: collection_path, alert: "The packages visibility was updated."
  end

  member_action :update_metadata, method: :put do
    hash = { name: resource.name, custom_repo: resource.repo }
    npm = NPM::Package.new(hash, fetch: true)
    github = Github::Repository.new(npm, fetch: true)

    resource.assign_npm_attributes(npm)
    resource.assign_github_attributes(github)
    resource.last_fetched = Time.now
    resource.auto_review.save!

    redirect_to resource_path, notice: "The package metadata was updated."
  end

  member_action :toggle_visibility, method: :put do
    resource.hidden = !resource.hidden
    resource.save!
    redirect_to resource_path, notice: "The package visibility was updated."
  end

  member_action :pending, method: :put do
    resource.pending!
    redirect_to resource_path, notice: "The package transitioned to pending."
  end

  member_action :reject, method: :put do
    resource.reject!
    redirect_to resource_path, notice: "The package transitioned to rejected."
  end

  member_action :unpublish, method: :put do
    resource.accept!
    redirect_to resource_path, notice: "The package transitioned to accepted."
  end

  member_action :publish, method: :put do
    resource.publish!
    redirect_to resource_path, notice: "The package transitioned to published."
  end

  action_item :update_metadata, only: :show do
    link_to "Update metadata", update_metadata_sudo_package_path(package), method: :put
  end

  action_item :toggle_visibility, only: :show do
    label = package.hidden? ? "Show package" : "Hide package"
    link_to label, toggle_visibility_sudo_package_path(package), method: :put
  end

  action_item :reject, only: :show do
    unless package.rejected? or package.published?
      link_to "Reject", reject_sudo_package_path(package), method: :put
    end
  end

  action_item :other_states, only: :show do
    if package.rejected?
      link_to "Pending", pending_sudo_package_path(package), method: :put
    elsif package.accepted?
      link_to "Publish", publish_sudo_package_path(package), method: :put
    elsif package.published?
      link_to "Unpublish", unpublish_sudo_package_path(package), method: :put
    end
  end
end
