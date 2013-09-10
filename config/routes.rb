Ticketee::Application.routes.draw do
  get "users/show"
  get "users/create"
  get "users/new"
  #get "users/sign_out"
  get "/signin", to: "sessions#new"
  get "/signout", to: "sessions#sign_out"
  post "/signin", to: "sessions#create"
  root :to => "projects#index"
  resources :projects do
    resources :tickets
  end
  resources :tickets do
    resources :comments
  end
  resources :users
end
