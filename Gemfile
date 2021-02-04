source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.6'

gem 'rails', '~> 6.0.3', '>= 6.0.3.2'
gem 'devise'
gem 'milia', '~>1.3', :git => 'https://github.com/yshmarov/milia.git'
gem 'bootstrap', '~> 4.5.0'
gem 'twitter-bootstrap-rails', :git => 'git://github.com/seyhunak/twitter-bootstrap-rails.git'
gem 'devise-bootstrap-views'
gem 'pg'
gem 'jquery-ui-rails'
gem 'aws-sdk'
gem 'aws-sdk-s3', require: false
gem 'bootstrap4-datetime-picker-rails'
gem 'stripe'
gem 'puma', '~> 4.1'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 4.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'font-awesome-sass'
gem 'bootsnap', github: 'ojab/bootsnap', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end


group :production do
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'activerecord-session_store', github: 'rails/activerecord-session_store'
