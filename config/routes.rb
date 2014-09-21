Rails.application.routes.draw do

  resources :users, only: [:create, :destroy]

  resources :companies, only: [:show] do
    resources :jobs, only: [:show]
  end

  resources :jobs, only: [:index]
  resources :skills, only: [:index, :show]

  # templates
  resources :company_templates, only: [:show]
  resources :job_templates, only: [:index, :show]
  resources :skill_templates, only: [:show]
  resources :user_templates, only: [:new]

  get '/register', to: 'users#new'

  root 'jobs#index'
  match '*path', to: 'jobs#index', via: 'get'

end