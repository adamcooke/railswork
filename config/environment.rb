RAILS_GEM_VERSION = '1.2.5' unless defined? RAILS_GEM_VERSION
USER_SALT = "lewyx7b4o9xszbv83ns7hds"

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.action_controller.session = {
    :session_key => 'railswork_session',
    :secret      => 'vej3ijas1iskndf9jdsfiun8n19'
  }
  config.action_controller.session_store = :active_record_store
  config.load_paths += %W( #{RAILS_ROOT}/app/observers )
  config.action_mailer.default_url_options = {:host => "localhost:3000"}

end

require 'digest/sha1'

ActiveRecord::Base.observers = [:job_observer]
PAYPAL_CONFIG = YAML::load(ERB.new(IO.read("#{RAILS_ROOT}/config/paypal.yml")).result).symbolize_keys
