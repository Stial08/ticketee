Ticketee::Application.routes.draw do

  #devise_for :users

  devise_for :users, :controllers => {
    :registrations => "registrations",
    :omniauth_callbacks => "users/omniauth_callbacks"
  }

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
      resources :projects, defaults: {format: :json} do
        resources :tickets, defaults: {format: :json}
      end
    end
  end
end
