# encoding: utf-8
module EnumField
  VERSION = '0.1.2'
  
  autoload :DefineEnum, 'enum_field/define_enum'
  autoload :Builder, 'enum_field/builder'
  autoload :EnumeratedAttribute, 'enum_field/enumerated_attribute'
  
  class BadId < StandardError
    def initialize(repeated_id)
      @repeated_id = repeated_id
    end
    attr_reader :repeated_id
  end

  class RepeatedId < StandardError; end
  class InvalidId < StandardError; end
  class InvalidOptions < StandardError; end
  class ObjectNotFound < StandardError; end
end

Module.send(:include, EnumField::DefineEnum)
require 'enum_field/railtie' if defined?(Rails)
