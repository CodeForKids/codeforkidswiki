source 'https://rubygems.org'

gem 'rails', '4.1.1'
gem 'pg'

# Authentication with Google
gem 'devise'
gem 'omniauth-google-oauth2'

gem 'tinymce-rails'
gem 'will_paginate'
gem 'foundation-will_paginate'

gem 'sass-rails', '~> 4.0.2'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'font-awesome-sass'
gem 'foundation-rails'
gem 'turbolinks'
gem 'counter_culture', '~> 0.1.18'
gem 'fog', '~> 1.3.1', require: 'fog/aws/storage'
gem 'carrierwave'
gem 'acts-as-taggable-on'
gem 'pg_search'
gem 'jbuilder'

gem 'puma'
gem 'newrelic_rpm'
gem 'codeclimate-test-reporter', group: :test, require: nil
gem 'airbrake'
gem 'lograge'

group :production do
  gem 'remote_syslog_logger'
  gem 'rails_12factor'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :test do
  gem 'fakeweb'
  gem 'webmock', require: nil
end

group :development, :test do
  gem 'pry'
end
