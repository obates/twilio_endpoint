source 'https://rubygems.org'

group :production do
  gem 'foreman'
  gem 'unicorn'
end

gem 'twilio-ruby'

gem 'endpoint_base', :github => 'spree/endpoint_base', branch: 'master'

group :development, :test do
  gem 'pry'
  gem 'pry-byebug'
end

group :test do
  gem 'vcr'
  gem 'rspec'
  gem 'webmock'
  gem 'guard-rspec'
  gem 'terminal-notifier-guard'
  gem 'rb-fsevent', '~> 0.9.1'
  gem 'rack-test'
  gem 'timecop'
end

