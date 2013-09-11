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
    resources :tickets
  end
  resources :tickets do
    resources :comments
    resources :tags do
      member do
        delete :remove
      end
    end
  end
end
