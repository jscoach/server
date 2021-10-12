source 'https://rubygems.org'

ruby '2.4.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.4'
gem 'dotenv-rails'
gem 'pg'
gem 'devise'
gem 'activeadmin'
gem 'puma', '~> 4.3'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'jbuilder', '~> 2.5'

gem 'recursive-open-struct' # OpenStruct that supports nested hashes, used for app config
gem 'mechanize' # Makes automated web interaction easy
gem 'state_machines-activerecord' # Create state machines for attributes on any ruby class
gem 'friendly_id' # Friendly URLs
gem 'colorize' # String class extension. Adds methods to set color and text effect on console
gem 'octokit' # Official Ruby toolkit for the GitHub API
gem 'progress_bar', require: false # Terminal progress bar used by some rake tasks
gem 'pg_search' # Named scopes that take advantage of PostgreSQL's full text search
gem 'draper' # Presentation logic for resources using decorators
gem 'kaminari' # For pagination
gem 'memoist' # ActiveSupport::Memoizable with a few enhancements
gem 'exception_notification' # Exception notifier for Rails
gem 'slack-notifier' # Slack integration for the `exception_notification` gem
gem 'redcarpet' # The safe Markdown parser, reloaded
gem 'twitter', require: false
gem 'algoliasearch-rails'
gem 'html_truncator'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'pry-rails' # An IRB alternative and runtime developer console
end

group :test do
  gem 'minitest' # For a newer version than the one that comes with ruby
  gem 'minitest-spec-rails' # Make Rails use MiniTest::Spec
  gem 'minitest-metadata', require: false # Annotate tests (eg: `it "...", js: true do`)
  gem 'minitest-rg' # Adds red/green color to your Minitest output
  gem 'database_cleaner' # Ensure a clean database during tests
  gem 'capybara' # Simulates how a user would interact with the app
  gem 'capybara_minitest_spec' # MiniTest expectations for Capybara
  gem 'poltergeist' # A PhantomJS driver for Capybara (requires `phantomjs` installation)
  gem 'fakeweb', github: "chrisk/fakeweb" # A test helper for faking responses to web requests
end

group :production do
  gem 'webpacker', require: false # Add webpacker so Heroku runs yarn install automatically
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
