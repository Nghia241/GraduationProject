source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.0"

# Rails framework
gem "rails", "~> 7.0.4"

# Asset pipeline
gem "sprockets-rails"

# Database
gem 'sqlite3', '~> 1.4'
gem 'mysql2', '~> 0.5.3'

# Authentication
gem 'devise', '~> 4.9.0'

# ORM Adapter (phiên bản mới nhất)
gem 'orm_adapter', '~> 0.5.0'

# ActiveRecord utilities
gem 'activerecord'
gem 'active_storage_validations'

gem 'dotenv-rails', groups: [:development, :test]

gem 'jquery-rails'          # Chỉ giữ lại nếu thực sự cần

# Web server
gem "puma", "~> 5.0"

# Hotwire (Turbo và Stimulus)
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"

# Debugging và công cụ hỗ trợ
gem "pry"
gem "rqrcode"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
