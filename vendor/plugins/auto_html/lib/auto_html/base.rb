# encoding: utf-8
module AutoHtml
  module Base
    module InstanceMethods
      def auto_html(raw, &proc)
        unless raw.blank?
          builder = AutoHtml::Builder.new(raw)
          builder.instance_eval(&proc)
        end
      end
    end
  end
end

