Rails.application.routes.draw do

  resources :users, only: [:create, :update, :destroy]
  get '/users/current_user', to: 'users#logged_in_user'
  resources :seekers, only: [:show, :update]
  get '/seekers/:id/favorite/:job_id', to: 'seekers#favorite'
  get '/seekers/:id/remove/:job_id', to: 'seekers#unfavorite'

  resources :companies, only: [:show, :update] do
    resources :jobs, only: [:create, :show, :update, :destroy]
  end

  root 'jobs#index'
  resources :jobs, only: [:index]
  resources :skills, only: [:index, :show]

  get '/register', to: 'users#new'
  get '/login', to: 'session#new'
  post '/login', to: 'session#create'
  delete '/logout', to: 'session#destroy'

  # templates
  resources :user_templates, only: [:new]
  resources :seeker_templates, only: [:show]
  resources :company_templates, only: [:show]
  resources :job_templates, only: [:index, :show]
  resources :skill_templates, only: [:show]
  resources :session_templates, only: [:new]

  match '*path', to: 'jobs#index', via: 'get'

end