source 'https://rubygems.org'

git_source(:github) { |_repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

gem 'jbuilder'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.4', '>= 7.0.4.3'

gem 'bootsnap', require: false
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :test do
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'shoulda-matchers'
end

group :development, :test do
  gem 'faker'
  gem 'pry'
  gem 'rspec-rails'
end
