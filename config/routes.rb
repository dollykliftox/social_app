# frozen_string_literal: true

Rails.application.routes.draw do
  resources :posts
  devise_for :users,
             controllers: {
               omniauth_callbacks: 'users/omniauth_callbacks'
             }
  # # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # root 'homes#index'
  root 'billings#index', as: :billing 
  get '/card/new' => 'billings#new_card', as: :add_payment_method
  post "/card" => "billings#create_card", as: :create_payment_method
  get '/success' => 'billings#success', as: :success
  get '/orders', :to => 'orders#index'
  post :create_order, :to => 'orders#create_order'
  post :capture_order, :to => 'orders#capture_order'
  resources :charges
  resources :coffee_roasts 
  resources :posts
end
