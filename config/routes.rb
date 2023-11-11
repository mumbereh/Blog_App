Rails.application.routes.draw do
  root "users#index"

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show]
  end

  resources :posts, only: [:index, :show, :new, :create] do
    resources :comments, only: [:new, :create]
    resources :likes, only: [:new, :create]

    member do
      post 'like'
    end
  end

  get '/posts/:post_id/comments/new', to: 'comments#new', as: 'new_post_comment'
end
