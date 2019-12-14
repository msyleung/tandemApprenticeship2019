source 'https://rubygems.org'
ruby '2.4.1'

# Sinatra
gem 'sinatra', '2.0.7'
gem 'sinatra-contrib', require: false
gem 'activesupport'
gem 'sinatra-activerecord'
gem 'rake'
# Calendar view
gem 'calendar_helper', '~> 0.2.6'

group :test do
  gem 'rspec'
end

group :test, :development do
  gem 'better_errors'
  gem 'pry'
  # Database
  gem 'sqlite3'
end

group :production do
  # Database for Heroku
  gem 'pg'
end
