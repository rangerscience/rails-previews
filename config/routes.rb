RailsPreviews::Engine.routes.draw do
  get "/", to: "previews#index" # TODO: `internal: true` ...?
  get "/*path", to: "previews#show", as: :preview # TODO: `internal: true` ...?
end
