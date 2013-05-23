module Rails
  module Generators
    class ControllerGenerator < NamedBase # :nodoc:
      argument :actions, type: :array, default: [], banner: "action action"
      check_class_collision suffix: "Controller"

      def create_controller_files
        template 'controller.rb', File.join('app/controllers', class_path, "#{scrub_file_name}_controller.rb")
      end

      def add_routes
        actions.reverse.each do |action|
          route %{get "#{file_name}/#{action}"}
        end
      end

      def class_name
        (class_path + [scrub_file_name]).map!{ |m| m.camelize }.join('::')
      end

      def scrub_file_name
        @scrubbed_name ||= file_name.gsub(/_controller$/,'')
      end

      hook_for :template_engine, :test_framework, :helper, :assets
    end
  end
end
