Rails.application.routes.draw do
  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
  resources :hardwares, only: [:index] do
    collection do
      post :set_temp
      post :hold_at
      post :boil
      post :grind
      post :fill
      post :whirlpool_valve
      post :wort_pipe_valve
      post :wort_pump
      post :drain_valve
      post :cip_pump
    end
  end
  resources :brew_session_logs, only: [:new, :create, :index] do
    collection do
      get :index_table
    end
  end
end