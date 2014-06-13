require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CfkWiki
  class Application < Rails::Application
    config.autoload_paths += Dir["#{config.root}/lib/**/"]
    config.action_view.sanitized_allowed_tags = 'table', 'tr', 'td', 'iframe'
    config.action_view.sanitized_allowed_attributes = 'id', 'class', 'style', 'border'
  end
end
