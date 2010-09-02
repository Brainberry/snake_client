require 'ipaddr'
require 'has_ip_address/extensions'

module HasIpAddress
  autoload :Utils, 'has_ip_address/utils'
  
  def self.included(base)
    base.send :extend, ClassMethods
  end

  module ClassMethods
    def has_ip_address(*columns)
      columns ||= :ip_address
      
      [columns].flatten.each do |column|
        define_method "#{column}=" do |address|
          ipaddr = address.blank? ? nil : address.to_ipaddr
          write_attribute column, ipaddr

          ipaddr
        end

        define_method column do
          integer = read_attribute column
          if integer.present?
            IPAddr.new(Utils::i_to_ipaddr(integer))
          end
        end
      end
    end
  end
end

require 'has_ip_address/railtie' if defined?(Rails)
