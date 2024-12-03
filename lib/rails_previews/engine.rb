require "rails"

module RailsPreviews
  class Engine < Rails::Engine
    isolate_namespace RailsPreviews
  end
end
