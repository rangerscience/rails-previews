
require "rails/application_controller"

class Rails::Previews::PreviewsController < ApplicationController
  layout false

  def index
    @previews = Rails::Previews::Preview.all
    render "previews/index", layout: false
  end

  def show
    Rails::Previews::Preview.all # TODO: Autoloading instead (ideally)

    klazz_name = Pathname.new(params[:path]).parent.to_s
    klazz = "Previews::#{klazz_name.camelize}".constantize

    example_name = Pathname.new(params[:path]).basename.to_s
    example = klazz.new.send(example_name)

    if example.is_a? Hash
      render **example
    else
      render example
    end
  end
end
