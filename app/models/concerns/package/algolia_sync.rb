class Package < ActiveRecord::Base
  module AlgoliaSync
    extend ActiveSupport::Concern

    include AlgoliaSearch

    included do

      # Configuration based on this one by Algolia: https://goo.gl/ZFwceC
      # Callbacks run after commit, so collections, filters and categories are assigned
      algoliasearch id: :name, if: :should_sync_with_algolia?, per_environment: true do
        attribute :name

        attribute :description { humanized_description }
        attribute :latestRelease { latest_release }
        attribute :publishedAt { published_at }
        attribute :modifiedAt { modified_at }
        attribute :downloads { last_month_downloads }
        attribute :repositoryUser { repo_user }
        attribute :repositoryName { repo_name }
        attribute :collections { collections_for_algolia }
        attribute :categories { categories_for_algolia }
        attribute :styling { styling_for_algolia }
        attribute :compatibility { compatibility_for_algolia }
        attribute :license { normalized_license }
        attribute :stars
        attribute :dependents
        attribute :keywords
        attribute :readme

        # We're restricting the search to use a subset of the attributes only.
        # Unordered means matching words at the beginning of that attribute will
        # be considered as important as words that occur later in the attribute.
        # Learn more: https://goo.gl/MrLjGb
        searchableAttributes [
          'unordered(name)',
          'unordered(description)',
          'unordered(keywords)',
          'repositoryUser'
        ]

        attributesForFaceting [
          :collections,
          :categories,
          :styling,
          :compatibility
        ]

        customRanking [
          'desc(stars)',
          'desc(dependents)',
          'desc(downloads)',
          'desc(modifiedAt)'
        ]

        # Disable prefix search capabilities (matching words with only
        # the beginning) for the following attributes:
        disablePrefixOnAttributes [
          :keywords,
          :repositoryUser
        ]

        # Default typo-tolerance is disabled for the following attributes:
        disableTypoToleranceOnAttributes [
          :keywords
        ]

        # By default, separators are not indexed. Learn more: https://goo.gl/EUkfFx
        separatorsToIndex [
          '_'
        ]
      end
    end

    def should_sync_with_algolia?
      published? && collections_for_algolia.any?
    end

    def collections_for_algolia
      collections.where(default: true).where("slug != 'browserify'").map(&:name)
    end

    def categories_for_algolia
      categories.map(&:name)
    end

    def styling_for_algolia
      filters.map(&:name).select { |n| n == 'Inline Styles' }
    end

    def compatibility_for_algolia
      if collections.find_by(slug: "react-native").present?
        compatibility = filters.map(&:name).select { |n| ['Android', 'iOS', 'Windows', 'Web', 'Expo'].include? n }

        # If package doesn't have keywords and platform specific languages, we assume it works on all platforms
        compatibility += ['Android', 'iOS', 'Windows'] if compatibility.select { |n| ['Android', 'iOS', 'Windows'].include? n }.empty?
        compatibility
      else
        []
      end
    end
  end
end
