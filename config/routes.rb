# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  scope "(:locale)", locale: /pt-BR|en/ do
    # Defines the root path route ("/")
    root "home#index"

    # Devise routes for User::Admin authentication
    devise_for :admins, class_name: "User::Admin"
    resources :answers
    resources :collections
    resources :equations
    resources :groupings
    resources :participants, module: :user
    resources :reports, only: [ :index, :show, :destroy ]

    resources :equations, only: [] do
      resources :collections, only: [] do
        member do
          patch "remove", to: "collections#remove_equation", as: :remove
        end
      end
    end

    resources :participants, module: :user, only: [] do
      resources :groupings, only: [] do
        member do
          patch "remove", to: "groupings#remove_participant", as: :remove
        end
      end
    end

    resources :rounds, param: :round_id, only: [ :new ] do
      collection do
        post "start"
      end

      member do
        post "submit_answer"
        get "finish"
      end
    end
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
