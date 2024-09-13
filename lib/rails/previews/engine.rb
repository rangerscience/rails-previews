module Rails
  module Previews
    class Engine < ::Rails::Engine
      isolate_namespace Rails::Previews
    end
  end
end
