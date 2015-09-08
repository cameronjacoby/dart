Rails.application.routes.draw do

  root "site#index"

  # api routes
  namespace :api, defaults: { format: :json } do
    resources :jobs, only: [:index, :show]
    resources :roles, only: [:index]
    resources :locations, only: [:index]
    get "/users/current", to: "users#current"
  end

  # auth routes
  post "/auth/signup", to: "auth#signup"
  post "/auth/login", to: "auth#login"
  post "/auth/:provider", to: "auth#authenticate"

  get "*path", to: "site#index"

end