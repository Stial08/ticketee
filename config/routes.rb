Ticketee::Application.routes.draw do
  get "users/show"
  get "users/create"
  get "users/new"
  root :to => "projects#index"
  resources :projects do
    resources :tickets
  end
  resources :users
end
