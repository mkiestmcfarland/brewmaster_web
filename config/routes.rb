Rails.application.routes.draw do
  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
  resources :hardwares, only: [:new] do
    collection do
      post :set_temp
      post :hold_at
    end
  end
  resources :brew_session_logs, only: [:new, :create, :index]
end