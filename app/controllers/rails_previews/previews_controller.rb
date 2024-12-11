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

  def show
    RailsPreviews::Preview.all # TODO: Autoloading instead (ideally)

    example = example_class.new.send(example_name)

    if example.is_a? Hash
      render **example, layout: resolve_layout
    else
      render example, layout: resolve_layout
    end
  end
end
