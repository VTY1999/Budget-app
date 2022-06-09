Rails.application.routes.draw do
  devise_for :users
  resources :categories do
    resources :entities
  end

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
    end

  unauthenticated do
    root "splashes#index"
  end

  authenticated :user do
    root 'categories#index', as: :authenticated_root
  end
end
