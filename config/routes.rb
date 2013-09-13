Ticketee::Application.routes.draw do
  get "users/show"
  get "users/create"
  get "users/new"
  get "/signin", to: "sessions#new"
  get "/signout", to: "sessions#sign_out"
  post "/signin", to: "sessions#create"
  root :to => "projects#index"
  resources :users
  resources :projects do
    resources :tickets do
      collection do
        get :search
      end
      member do 
      post :watch
      end
    end
  end
  resources :tickets do
    resources :comments
    resources :tags do
      member do
        delete :remove
      end
    end
  end
  ### API
  namespace :api do
    namespace :v1 do
      resources :projects do
        resources :tickets, defaults: {format: :json}
      end
    end
  end
end
