source 'http://rubygems.org'

gem 'rails', '3.2.1'
gem 'haml-rails', '>= 0.3.4'
gem 'jquery-rails', '>= 0.2.7'
gem 'rails-backbone', '>= 0.5.3'
gem 'backbone-support', '>= 0.2.0'
gem 'jruby-openssl'
gem 'torquebox-rake-support', '2.0.3'
gem 'torquebox', '2.0.3'

gem 'puma'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'jquery-ui-rails'
  gem 'uglifier', '>= 1.0.3'
end

group :development, :test do
  gem 'factory_girl_generator', '>= 0.0.1'
  gem 'rspec-rails', '>= 2.5.0'
  gem 'shoulda'
  gem 'shoulda-matchers', :git => 'git://github.com/thoughtbot/shoulda-matchers.git'
  gem 'ruby-debug-base'
  gem 'ruby-debug'
end

group :production, :development do
  gem 'jdbc-postgres'
  gem 'activerecord-jdbcpostgresql-adapter'
end

group :test do
  gem 'factory_girl_rails', '>= 1.0.1'
  gem 'json_spec'
  gem 'simplecov', '0.5.4'
  gem 'turn', '0.8.2', :require => false
  gem 'webmock'
  gem 'jdbc-sqlite3'
  gem 'activerecord-jdbcsqlite3-adapter'
end