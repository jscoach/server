class Package < ActiveRecord::Base
  module AlgoliaSync
    extend ActiveSupport::Concern

    include AlgoliaSearch

    included do
      # Configuration based on this one by Algolia: https://goo.gl/ZFwceC
      # Callbacks run after commit, so collections, filters and categories are already assigned.
      # Callbacks don't run when associations change. `after_remove` and `after_add` can be added to the HABTMs.
      algoliasearch id: :name, if: :should_sync_with_algolia?, force_utf8_encoding: true, per_environment: true do
        attribute :name

        attribute :description { humanized_description }
        attribute :latestRelease { latest_release }
        attribute :publishedAt { published_at }
        attribute :modifiedAt { modified_at }
        attribute :pushedAt { pushed_at }
        attribute :downloads { last_month_downloads }
        attribute :repositoryName { repo_name }
        attribute :repositoryUser { repo_user }
        attribute :repositoryUserAvatar { repo_user_avatar }
        attribute :customRepoPath { custom_repo_path }
        attribute :collections { collections_for_algolia }
        attribute :categories { categories_for_algolia }
        attribute :styling { styling_for_algolia }
        attribute :compatibility { compatibility_for_algolia }
        attribute :license { license_for_algolia }
        attribute :stars
        attribute :dependents
        attribute :keywords
        attribute :readme { readme_for_algolia }
        attribute :readmeWasTruncated { readme_was_truncated_for_algolia }
        attribute :communityPick { community_pick_for_algolia }
        attribute :homepage { homepage_for_algolia }
        attribute :donationUrl { donation_url }

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

        # Define a replica index with custom ordering but same settings than the main block
        add_replica 'Package_updated_at', inherit: true, per_environment: true do
          customRanking ['desc(modifiedAt)']
        end
      end
    end

    # Truncate the readme if it's too long. Truncation is done by counting characters but some
    # readmes may be very long in terms of HTML and have few characters if they include lots of
    # images for example. We try to cut at 20 000 and if it's still to big we try half the size.
    # Keep in mind that records in Algolia must be smaller than 10kb.
    def readme_for_algolia
      options = { length_in_chars: true, ellipsis: '' }
      HTML_Truncator.self_closing_tags = %w(br hr img input)
      HTML_Truncator.punctuation_chars = []

      truncated = HTML_Truncator.truncate(readme, readme_max_chars || 20_000, options)
      truncated = HTML_Truncator.truncate(readme, 10_000, options) if truncated.length > 50_000

      # We could always return `truncated` but we avoid it because of possible markup changes
      truncated.html_truncated? ? truncated : readme
    end

    def readme_was_truncated_for_algolia
      readme_for_algolia.try :html_truncated?
    end

    def should_sync_with_algolia?
      published? && collections_for_algolia.any?
    end

    def collections_for_algolia
      collections.where(default: true).map(&:name)
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

    def community_pick_for_algolia
      filters.find_by(slug: "community-pick").present?
    end

    # Use the homepage field from npm, unless if it points to GitHub, because that's redundant
    # If unavailable, use the homepage in the GitHub page itself, if existent
    def homepage_for_algolia
      return homepage unless homepage.to_s.include? "github.com"
      github_homepage unless github_homepage.to_s.include? "github.com"
    end

    def license_for_algolia
      normalized_license.presence || github_license
    end
  end
end
