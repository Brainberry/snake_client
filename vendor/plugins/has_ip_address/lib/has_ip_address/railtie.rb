# encoding: utf-8
require 'has_ip_address'

module HasIpAddress
  if defined? Rails::Railtie
    require 'rails'
    class Railtie < Rails::Railtie
      config.before_initialize do
        ActiveSupport.on_load :active_record do
          ActiveRecord::Base.send :include, HasIpAddress
        end
      end
    end
  end
end
