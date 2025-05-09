class RailsPreviews::PreviewsController < ::ApplicationController
  # TODO: Seems like this shouldn't be necessary, but main app paths weren't available as helpers
  # ...and, definitely shouldn't be necssary to flail like this.
  include Rails.application.routes.url_helpers

  class << self
    include Rails.application.routes.url_helpers
  end

  def index
    @previews = RailsPreviews::Preview.all
    render "previews/index", layout: "previews"
  end

  def resolve_layout
    params[:path].start_with?("storybook/") ? "storybook" : "previews"
  end

  def example_path
    params[:path].delete_prefix("storybook/")
  end

  def example_class_name
    Pathname.new(example_path).parent.to_s
  end

  def example_class
    "Previews::#{example_class_name.camelize}".constantize
  end

  def example_name
    Pathname.new(example_path).basename.to_s
  end

  def var_select(it)
    !it.starts_with?("@_") && !it.starts_with?("@current")
  end

  def show
    RailsPreviews::Preview.all # TODO: Autoloading instead (ideally)

    controller = example_class.new
    example = controller.send(example_name)

    controller.instance_variables.select { var_select it }.each do |var|
      instance_variable_set(var, controller.instance_variable_get(var))
    end

    # WIP - This is the implied controller / view folder, and should have options to that effect..?
    lookup_context.prefixes.prepend example_class_name

    if example.is_a? Hash
      render **example, layout: resolve_layout
    else
      render example, layout: resolve_layout
    end
  end

  def current_user
    example_class.send(:current_user)
  end
end
