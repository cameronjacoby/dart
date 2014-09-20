Rails.application.routes.draw do

  resources :seekers, except: [:index, :new, :edit]

  resources :companies, except: [:index, :new, :edit] do
    resources :jobs, except: [:index, :new, :edit]
  end

  resources :jobs, only: [:index]

  root 'jobs#index'
  match '*path', to: 'jobs#index', via: 'get'

end