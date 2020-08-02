Rails.application.routes.draw do
  resources :artifacts
  resources :projects
  root "home#index"

  # Такое вложение позволяет делать URL вида tenant#/project# , т.е. одной организации может принадлежать несколько проектов
  resources :tenants do
    resources :projects do
      get 'users', on: :member
      put 'add_user', on: :member
    end
  end

  # Переадресация из MILIA, т.к. она автоматическпи пересылает на welcome после входа
  get 'welcome', to: 'home#index'

  resources :members


  # *MUST* come *BEFORE* devise's definitions (below)
  as :user do   
    match '/user/confirmation' => 'confirmations#update', :via => :put, :as => :update_user_confirmation
  end

  devise_for :users, :controllers => { 
    :registrations => "registrations",
    :confirmations => "confirmations",
    :sessions => "milia/sessions",
    :passwords => "milia/passwords"
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
