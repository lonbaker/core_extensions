module ActiveRecord
  class Base
    class << self
      def boolean_field(*args)
        args.each {|prop| class_eval("def #{prop}?; #{prop} === true || #{prop} === 1 end") }
      end
    end
  end
end

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

    def distance_of_time_for(obj, method)
      "<span title=\"#{obj.send(method).localtime}\">#{distance_of_time_in_words_to_now(obj.send(method).localtime)}</span>"
    end
  
    def back_link(text='Back', *args)
      link_to text, (request.referrer || 'javascript:history.go(-1)'), *args
    end

    def current_controller?(*options)
      options = options[1] if options.is_a?(Array)
      return false unless options.useful? || options.is_a?(Hash)
      opts = options.dup
      opts[:action] = :index
      url_for({:action => :index}) == url_for(opts)
    end
  end
end
