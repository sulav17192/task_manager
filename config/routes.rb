Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root "dashboard#index"
  get "dashboard", to: "dashboard#index"

  resources :tasks do
    member do
      patch :mark_complete
    end
  end

  namespace :admin do
    get "managers/invite_manager"
    resources :users
  end

  namespace :admin do
  resources :managers do
    post :invite_manager, on: :collection
  end
end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
