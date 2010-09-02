# encoding: utf-8
module AutoHtml
  autoload :Base, 'auto_html/base'
  autoload :Filter, 'auto_html/filter'
  autoload :Builder, 'auto_html/builder'
  autoload :AutoHtmlFor, 'auto_html/auto_html_for'
  
  class << self
    def add_filter(name, &block)
      Builder.add_filter(name, &block)
    end
  end
end

require 'auto_html/railtie' if defined?(Rails)
