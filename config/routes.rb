Rails.application.routes.draw do

  resources :seekers, except: [:index, :new, :edit]

  resources :companies, except: [:index, :new, :edit] do
    resources :jobs, except: [:index, :new, :edit]
  end

  resources :jobs, only: [:index]

  resources :skills, only: [:index, :show]

  # templates
  resources :company_templates, only: [:show]
  resources :job_templates, only: [:index, :show]
  resources :skill_templates, only: [:show]

  root 'jobs#index'
  match '*path', to: 'jobs#index', via: 'get'

end