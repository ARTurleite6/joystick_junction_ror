# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  resources :reviews, only: %i[index create] do
    get :top, on: :collection
  end

  resources :games, only: %i[index show] do
    get :trending, on: :collection
    get :search, on: :collection
  end

  resources :users do
    get :reviews, on: :member
    post :follow, on: :member
  end

  # Defines the root path route ("/")
  # root "posts#index"
end
