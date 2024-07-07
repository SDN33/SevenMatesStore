source "https://rubygems.org"

ruby "3.3.0"

# Rails framework
gem "rails", "~> 7.1.3"

# Asset pipeline
gem "sprockets-rails"

# Database adapter
gem "sqlite3", "~> 1.4"

# Web server
gem "puma", ">= 5.0"

# JavaScript with ESM import maps
gem "importmap-rails"

# Hotwire's Turbo
gem "turbo-rails"

# Stimulus JavaScript framework
gem "stimulus-rails"

# Build JSON APIs
gem "jbuilder"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Bootsnap for faster boot times
gem "bootsnap", require: false

# Active Storage variants
# gem "image_processing", "~> 1.2"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ] # Debugging
end

group :development do
  gem "web-console" # Console on exceptions pages
  # gem "rack-mini-profiler" # Speed badges
  # gem "spring" # Speed up commands on slow machines / big apps
end

# PostgreSQL adapter for production
gem 'pg'
gem 'dotenv-rails', groups: [:development, :test]

# Solidus e-commerce platform
gem "solidus", "~> 4.3"
gem "solidus_auth_devise", "~> 2.5"
gem "solidus_admin", ">= 0.2"
gem "solidus_support"
gem "solidus_paypal_commerce_platform", "~> 1.0"
gem 'solidus_backend'
gem 'solidus_frontend'

# Other gems
gem "responders"
gem "canonical-rails"
gem "truncate_html"
gem "view_component", "~> 3.0"
gem "tailwindcss-rails"
gem "bootstrap", "~> 4.6.0"

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "capybara-screenshot", "~> 1.0"
  gem "database_cleaner", "~> 2.0"
end

group :development, :test do
  gem "rspec-rails"
  gem "rails-controller-testing", "~> 1.0.5"
  gem "rspec-activemodel-mocks", "~> 1.1.0"
  gem "factory_bot", ">= 4.8"
  gem "factory_bot_rails"
  gem 'ffaker', '~> 2.13'
  gem 'rubocop', '~> 1.0'
  gem 'rubocop-performance', '~> 1.5'
  gem 'rubocop-rails', '~> 2.3'
  gem 'rubocop-rspec', '~> 2.0'
end
