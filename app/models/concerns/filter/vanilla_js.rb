class Filter < ActiveRecord::Base
  module VanillaJs
    extend ActiveSupport::Concern

    class_methods do
      def discover_vanilla_js(collection, pkg)
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
