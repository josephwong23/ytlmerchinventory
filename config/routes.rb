Rails.application.routes.draw do
  devise_for :users,
    path_names: { registration: 'ytlcc'},
    controllers: { registrations: "registrations" }

  resources :orders
  resources :members
  resources :users
  resources :items
  resources :member_divisions, only: [:create]
  resources :categories, only: [:create]

  root 'orders#index'
  get 'renew/:id' => 'orders#renew'
  get 'return/:id' => 'orders#disable'
  get 'toggle_deliver/:id' => 'orders#toggle_deliver'
  get 'past_orders' => 'orders#old'

  get '/logs' => 'user_logs#index'
end
