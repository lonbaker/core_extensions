module ActionController
  class AbstractRequest
    def referrer
      self.env['HTTP_REFERER']
    end
  end

  class Base
    class << self
      def simple_action(*actions)
        actions.each {|action| class_eval("def #{action}; end")}
      end
    end
  end
end

module ApplicationHelper
  module_eval do
    def stylesheet_controller_tag
      stylesheet_link_tag(controller.controller_name) if 
        public_file_exists?(stylesheet_path(controller.controller_name))
    end

    def javascript_controller_tag
      javascript_include_tag(controller.controller_name) if 
        public_file_exists?(javascript_path(controller.controller_name))
    end

    def javascript_action_tag
      name = "#{controller.controller_name}_#{controller.action_name}"
      javascript_include_tag(name) if 
        public_file_exists?(javascript_path(name))
    end

    def public_file_exists?(file)
      File.exist?(public_file_path(file))
    end

    def public_file_path(file)
      file ||= ''
      File.expand_path(File.join(RAILS_ROOT, 'public', file.gsub(/\?.*$/, '')))
    end
  end
end
