source 'http://rubygems.org'

gem 'rails', '3.2.1'
gem 'haml-rails', '>= 0.3.4'
gem 'jquery-rails', '>= 0.2.7'
gem 'rails-backbone', '>= 0.5.3'
gem 'backbone-support', '>= 0.2.0'
gem 'pusher', '0.9.2'
gem 'newrelic_rpm', '3.3.2'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :development, :test do
  gem 'factory_girl_generator', '>= 0.0.1'
  gem 'rspec-rails', '>= 2.5.0'
  gem 'shoulda'
  gem 'shoulda-matchers', :git => 'git://github.com/thoughtbot/shoulda-matchers.git'
  gem 'sqlite3'
  gem 'pry'
  gem 'ruby-debug19', :require => 'ruby-debug'
  gem "ruby-debug-pry", :require => "ruby-debug/pry"
  gem 'pry-rails'
end

group :production do
  gem 'pg'
end

group :test do
  gem 'factory_girl_rails', '>= 1.0.1'
  gem 'json_spec'
  gem 'simplecov', '0.5.4'
  gem 'turn', '0.8.2', :require => false
  gem 'webmock'
end
