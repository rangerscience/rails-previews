module Rails::Previews
  class Preview
    def render_partial(name, locals = {})
      { partial: name, locals: locals }
    end

    def render_react_on_rails(name, pack: "application", props: {})
      raise "React on Rails is not installed - did you add the gem?" unless defined?(ReactOnRails)

      {
        partial: "previews/react_on_rails",
        locals: {
          pack: pack,
          component_name: name,
          props: props
        }
      }
    end

    class << self
      # TODO: Use regular Rails autoloading
      def all
        load_previews!
        descendants
      end

      def load_previews!
        Array(preview_paths).each do |preview_path|
          Dir["#{preview_path}/**/*.rb"].sort.each { |file| require_dependency file }
        end
      end

      def preview_paths
        [ "#{Rails.root}/spec/previews" ]
      end

      def preview_name
        name.delete_prefix("Previews::").underscore
      end

      def examples
        public_instance_methods(false).map(&:to_s).sort
      end
    end
  end
end
