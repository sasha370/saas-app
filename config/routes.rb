Rails.application.routes.draw do
  # Полный список путей для
  resources :artifacts
  resources :projects
  resources :members

  # Главная страница по адресу
  root "home#index"

  # Переадресация из MILIA, т.к. она автоматическпи пересылает на welcome после входа
  get 'welcome', to: 'home#index'



  # Такое вложение позволяет делать URL вида tenant#/project# , т.е. одной организации может принадлежать несколько проектов

  resources :tenants do
    resources :projects do
      get 'users', on: :member
      put 'add_user', on: :member
    end
  end


  # *MUST* come *BEFORE* devise's definitions (below)
  as :user do   
    match '/user/confirmation' => 'confirmations#update', :via => :put, :as => :update_user_confirmation
  end


  # Для User испоьзуются следующие контроллеры
  devise_for :users, :controllers => { 
    :registrations => "registrations",
    :confirmations => "confirmations",
    :sessions => "milia/sessions",
    :passwords => "milia/passwords"
  }

  # путь для изменения Тарифа
  match "/plan/edit" => 'tenants#edit', via: :get, as: :edit_plan
  match "/plan/update" => 'tenants#update', via: [:put, :patch], as: :update_plan
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
