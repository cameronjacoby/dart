Rails.application.routes.draw do

  get "/users/current_user", to: "users#logged_in_user"
  resources :users, only: [:create, :update, :destroy]
  resources :seekers, only: [:show, :update]

  resources :companies, only: [:show, :update] do
    resources :jobs, only: [:create, :show, :update, :destroy]
  end

  resources :jobs, only: [:index]
  resources :skills, only: [:index, :show]

  # templates
  resources :user_templates, only: [:new]
  resources :seeker_templates, only: [:show]
  resources :company_templates, only: [:show]
  resources :job_templates, only: [:index, :show]
  resources :skill_templates, only: [:show]
  resources :session_templates, only: [:new]

  get '/register', to: 'users#new'
  get '/login', to: 'session#new'
  post '/login', to: 'session#create'
  delete '/logout', to: 'session#destroy'

  root 'jobs#index'
  match '*path', to: 'jobs#index', via: 'get'

end