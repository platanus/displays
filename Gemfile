source 'https://rubygems.org'

gem 'rails', '~> 5.2.1'

gem 'active_skin'
gem 'activeadmin', '~> 1.3.0'
gem 'activeadmin_addons'
gem 'aws-sdk', '~> 3'
gem 'bootsnap', require: false
gem 'clockwork'
gem 'coffee-rails', '~> 4.2'
gem 'devise'
gem 'devise-i18n'
gem 'draper', '3.0.1'
gem 'enumerize'
gem 'jbuilder', '~> 2.5'
gem 'pg', '~> 0.21'
gem 'power-types'
gem 'puma', '~> 3.11'
gem 'rack-cors', '~> 0.4.0'
gem 'rails-i18n'
gem 'redis'
gem 'sass-rails', '~> 5.0'
gem 'spring'
gem 'strong_migrations'
gem 'uglifier', '>= 1.3.0'
gem 'webpacker', git: 'https://github.com/rails/webpacker.git'

group :production do
  gem 'heroku-stage'
  gem 'rack-timeout'
  gem 'rails_stdout_logging'
end

group :test do
  gem 'rspec_junit_formatter', '0.2.2'
  gem 'shoulda-matchers', require: false
end

group :development do
  gem 'annotate'
end

group :development, :test do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'guard-rspec', require: false
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rspec-nc', require: false
  gem 'rspec-rails'
end

group :production, :development, :test do
  gem 'tzinfo-data'
end
