module Rails
  module Previews
    class ApplicationRecord < ActiveRecord::Base
      self.abstract_class = true
    end
  end
end
