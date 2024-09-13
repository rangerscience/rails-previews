Rails.application.routes.draw do
  mount Rails::Previews::Engine => "/rails-previews"
end
