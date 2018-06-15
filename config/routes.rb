Rails.application.routes.draw do
  devise_for :users
  resources :orders
  resources :members
  resources :users
  resources :items
  resources :member_divisions, only: [:create]

  root 'orders#index'
  get 'renew/:id' => 'orders#renew'
  get 'return/:id' => 'orders#disable'
  get 'toggle_deliver/:id' => 'orders#toggle_deliver'
  get 'past_orders' => 'orders#old'
end
