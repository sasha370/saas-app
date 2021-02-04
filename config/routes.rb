Rails.application.routes.draw do
  resources :user_projects
  # Полный список путей для
  resources :artifacts
  resources :projects
  resources :members

  root "home#index"

  get 'welcome', to: 'home#index'

  resources :tenants do
    resources :projects do
      get 'users', on: :member
      put 'add_user', on: :member
    end
  end

  as :user do   
    match '/user/confirmation' => 'confirmations#update', :via => :put, :as => :update_user_confirmation
  end

  devise_for :users, :controllers => { 
    :registrations => "registrations",
    :confirmations => "confirmations",
    :sessions => "milia/sessions",
    :passwords => "milia/passwords"
  }

  match "/plan/edit" => 'tenants#edit', via: :get, as: :edit_plan
  match "/plan/update" => 'tenants#update', via: [:put, :patch], as: :update_plan

end
