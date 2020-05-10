class Category < ActiveRecord::Base
  module Node
    extend ActiveSupport::Concern

    class_methods do
      def discover_node(collection, pkg)
        categories = []
        keywords = pkg.keywords.to_a

        keywords.map(&:downcase).each do |keyword|
          # Everything that matches should have additional category
          categories << "a11y" if keyword.singularize =~ /a11y|accessibility/
          categories << "animation" if keyword.singularize =~ /animate|animation/
          categories << "boilerplates" if keyword.singularize =~ /generat|scaffold|boilerplate|yeoman|gulp|grunt/
          categories << "boilerplates" if keyword.singularize == "cli"
          categories << "data-flow" if keyword.singularize =~ /flux|redux|store|state|event|immutable|unidirectional/
          categories << "forms" if keyword.singularize =~ /^(form|date|time)$/
          categories << "forms" if keyword.singularize =~ /input|calendar|select|range|autocomplete|editable|textarea|slider|picker/
          categories << "i18n" if keyword.singularize =~ /i18n|internationalization/
          categories << "icons" if keyword.singularize =~ /icon|svg/
          categories << "images" if keyword.singularize =~ /image|img|photo|svg|gif/
          categories << "modals" if keyword.singularize =~ /modal|dialog/
          categories << "players" if keyword.singularize =~ /player|audio|video/
          categories << "practices" if keyword =~ /linter|eslint/
          categories << "rendering" if keyword.singularize =~ /render|express|template|view|dom/
          categories << "responsive" if keyword.singularize =~ /responsive/
          categories << "routers" if keyword.singularize =~ /route/
          categories << "setup" if keyword.singularize == "middleware"
          categories << "setup" if keyword.singularize =~ /babel|browserify|webpack|gulp|grunt/
          categories << "testing" if keyword.singularize =~ /test|mocha/
          categories << "transforms" if keyword.singularize =~ /^(loader)$/
          categories << "transforms" if keyword.singularize =~ /transform/
          categories << "cli" if keyword.singularize =~ /cli|terminal|bash/
          categories << "framework" if keyword.singularize =~ /framework/
        end

        categories.uniq.map { |slug| collection.categories.find(slug) }
      end
    end
  end
end
