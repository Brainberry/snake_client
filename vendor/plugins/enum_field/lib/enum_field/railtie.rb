# encoding: utf-8
require 'enum_field'

module EnumField
  if defined? Rails::Railtie
    require 'rails'
    class Railtie < Rails::Railtie
      config.before_initialize do
        ActiveSupport.on_load :active_record do
          ActiveRecord::Base.send(:extend, EnumField::EnumeratedAttribute)
        end  
      end
    end
  end
end
