class Filter < ActiveRecord::Base
  module Angular
    extend ActiveSupport::Concern

    class_methods do
      def discover_angular(collection, pkg)
        filters = []
        filters << collection.filters.find("inline-styles") if assign_inline_styles_filter? pkg
        filters
      end

      def assign_inline_styles_filter?(pkg)
        return false if pkg.languages.has_key? "CSS"
        return true
      end
    end
  end
end
