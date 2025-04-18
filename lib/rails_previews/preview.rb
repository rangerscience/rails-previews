module RailsPreviews
  class Preview
    def render_slim(template)
      { inline: template, type: :slim }
    end

    def render_partial(name, locals = {})
      { partial: name, locals: locals }
    end

    class << self
      def all
        load_previews! unless @loaded
        descendants
      end

      def load_previews!
        Array(preview_paths).each do |preview_path|
          Dir["#{preview_path}/**/*.rb"].sort.each { |file| require_dependency file }
        end
        @loaded = true
      end

      # TODO: The above method might not catch *new* files, but there appear to be
      #   some issues with the below:
      # def load_previews!
      #   @loaded_paths ||= []
      #   paths = preview_paths.flat_map { Dir["#{it}/**/*.rb"] }.sort
      #   (paths - @loaded_paths).each do |file|
      #     require_dependency file
      #     @loaded_paths << file
      #   end
      # end

      def preview_paths
        [ "#{Rails.root}/spec/previews" ]
      end

      def preview_name
        name.delete_prefix("Previews::").underscore
      end

      def examples
        public_instance_methods(false).map(&:to_s).sort
      end

      def current_user
        raise "No current user defined for this preview"
      end
    end
  end
end
