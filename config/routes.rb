Rails.application.routes.draw do
  devise_for :users

  resources :leads
  
  # Bulk import routes
  get 'bulk_imports/new', to: 'bulk_imports#new', as: :new_bulk_import
  post 'bulk_imports/search', to: 'bulk_imports#search', as: :search_bulk_imports
  post 'bulk_imports/import', to: 'bulk_imports#import', as: :import_bulk_imports
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "home#index"
end
