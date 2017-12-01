class Filter < ActiveRecord::Base
  module ReactNative
    extend ActiveSupport::Concern

    NATIVE_DIRECTORY_URL = "https://raw.githubusercontent.com/react-community/native-directory/master/build/data.json"

    ANDROID_LANGUAGES = ["Java"]
    IOS_LANGUAGES = ["Objective-C", "Swift"]
    WINDOWS_LANGUAGES = ["C#"]

    class_methods do
      def discover_react_native(collection, pkg)
        filters = []
        filters << collection.filters.find("android") if assign_android_filter? pkg
        filters << collection.filters.find("ios") if assign_ios_filter? pkg
        filters << collection.filters.find("windows") if assign_windows_filter? pkg
        filters << collection.filters.find("web") if assign_web_filter? pkg
        filters << collection.filters.find("expo") if assign_expo_filter? pkg
        filters
      end

      # @param languages A hash of languages from GitHub
      def has_android_language?(languages)
        (ANDROID_LANGUAGES & languages.keys).present?
      end

      # @param languages A hash of languages from GitHub
      def has_ios_language?(languages)
        (IOS_LANGUAGES & languages.keys).present?
      end

      # @param languages A hash of languages from GitHub
      def has_windows_language?(languages)
        (WINDOWS_LANGUAGES & languages.keys).present?
      end

      # @param languages A hash of languages from GitHub
      def has_native_language?(languages)
        ((ANDROID_LANGUAGES | IOS_LANGUAGES | WINDOWS_LANGUAGES) & languages.keys).present?
      end

      def assign_android_filter?(pkg)
        return true if has_android_language?(pkg.languages)
        return true if native_directory_package(pkg.name)["android"]

        # If there are native languages, check the keywords too
        #
        # Only if there are languages we use the keywords. This is because React.parts used
        # to recommend adding the `ios` keyword before react-native for android was released.
        # This approach gives more accurate results. More info: http://git.io/vErCb
        #
        has_android_keyword = pkg.keywords.join(" ").downcase.include? "android"
        return true if has_native_language?(pkg.languages) and has_android_keyword

        return false
      end

      def assign_ios_filter?(pkg)
        # Check if it has at least one iOS language
        return true if has_ios_language?(pkg.languages)
        return true if native_directory_package(pkg.name)["ios"]

        # If there are native languages, check the keywords too
        has_ios_keyword = pkg.keywords.join(" ").downcase.include? "ios"
        return true if has_native_language?(pkg.languages) and has_ios_keyword

        return false
      end

      def assign_windows_filter?(pkg)
        return true if has_windows_language?(pkg.languages)

        # If there are native languages, check the keywords too
        has_windows_keyword = pkg.keywords.join(" ").downcase.include? "windows"
        return true if has_native_language?(pkg.languages) and has_windows_keyword

        return false
      end

      def assign_web_filter?(pkg)
        native_directory_package(pkg.name)["web"]
      end

      def assign_expo_filter?(pkg)
        native_directory_package(pkg.name)["expo"]
      end

      # Get the metadata associated to a given package from the native.directory project
      # @return A hash with the package metadata
      def native_directory_package(package_name)
        package = native_directory_packages.detect { |pkg| package_name == pkg["npmPkg"] }
        package.nil? ? {} : package
      end

      # Grab a list of packages from the native.directory project
      # @return An array of hashes with package metadata
      def native_directory_packages(agent: URLHelpers.default_agent)
        @_native_directory_packages ||= begin
          JSON.parse(agent.get(NATIVE_DIRECTORY_URL).body)["libraries"]
        end
      end
    end
  end
end
