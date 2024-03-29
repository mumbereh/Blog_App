Rails.application.routes.draw do
  devise_for :users

  authenticate :user do
    root to: "users#index", as: :authenticated_root
  end

  unauthenticated :user do
    root to: "devise/sessions#new", as: :unauthenticated_root
  end

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :new, :show, :create] do
      resources :comments, only: [:new, :create]
      resources :likes, only: [:create]
    end
  end
end