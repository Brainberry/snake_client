# encoding: utf-8
module AutoHtml
  module AutoHtmlFor

    # default options that can be overridden on the global level
    @@auto_html_for_options = {
      :htmlized_attribute_suffix => '_html'
    }
    mattr_reader :auto_html_for_options

    def self.included(base)
      base.send(:extend, ClassMethods)
    end

    module ClassMethods
      def auto_html_for(raw_attrs, &proc)
        include AutoHtml::Base::InstanceMethods
        
        before_save :auto_html_prepare

        define_method("auto_html_prepare") do
          auto_html_methods = self.methods.select { |m| m=~/^auto_html_prepare_/ }
          auto_html_methods.each do |method|
            self.send(method)
          end
        end

        [raw_attrs].flatten.each do |raw_attr|
          define_method("auto_html_prepare_#{raw_attr}") do
            suffix = AutoHtmlFor.auto_html_for_options[:htmlized_attribute_suffix]
            self.send("#{raw_attr}#{suffix}=", auto_html(self.send(raw_attr), &proc))
          end
        end
      end
    end
  end
end
