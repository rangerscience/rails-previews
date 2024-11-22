class Rails::Previews::PreviewsController < ::ApplicationController
  # TODO: Seems like this shouldn't be necessary, but main app paths weren't available as helpers
  # ...and, definitely shouldn't be necssary to flail like this.
  include Rails.application.routes.url_helpers
  class << self
    include Rails.application.routes.url_helpers
  end

  def index
    @previews = Rails::Previews::Preview.all
    render "previews/index", layout: "previews"
  end

  def resolve_layout
    # TODO: Brittle!
    if request.headers["HTTP_ORIGIN"] == "http://localhost:6006"
      "storybook"
    else
      "previews"
    end
  end

  def show
    Rails::Previews::Preview.all # TODO: Autoloading instead (ideally)

    klazz_name = Pathname.new(params[:path]).parent.to_s
    klazz = "Previews::#{klazz_name.camelize}".constantize

    example_name = Pathname.new(params[:path]).basename.to_s
    example = klazz.new.send(example_name)

    if example.is_a? Hash
      render **example, layout: resolve_layout
    else
      render example, layout: resolve_layout
    end
  end
end
