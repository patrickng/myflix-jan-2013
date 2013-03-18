source "https://rubygems.org"
ruby '2.0.0'

gem 'rails', '3.2.13'
gem 'haml-rails'
gem 'bcrypt-ruby'
gem 'bootstrap-sass'
gem 'bootstrap_form'
gem 'figaro'
gem 'unicorn'
gem 'sidekiq'
gem 'sinatra', require: false
gem 'slim'
gem 'newrelic_rpm'
gem 'foreman'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :test, :development do
  gem 'rspec'
  gem 'rspec-rails'
  gem 'shoulda-matchers', github: "thoughtbot/shoulda-matchers", branch: "dc-bourne-dependency"
  gem 'fabrication'
  gem 'faker'
  gem 'pry'
  gem 'pry-nav'
  gem 'launchy'
end

group :development do
  gem 'sqlite3'
  gem 'better_errors'
  gem 'letter_opener'
end

group :test do
  gem 'capybara'
end

group :production do
  gem 'pg'
  gem 'sentry-raven'
end

gem 'jquery-rails'
