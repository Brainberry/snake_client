module HasIpAddress
  module Utils
    def self.i_to_ipaddr(value)
      [24, 16, 8, 0].collect {|b| (value >> b) & 255}.join('.')
    end
  end
end
