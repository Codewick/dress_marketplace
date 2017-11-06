Rails.application.routes.draw do

  resources :profiles
  resources :reviews
  resources :items do
    resources :reviews
  end
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
# get '/' => 'items#index'
  root :to => 'items#index'
  get 'items/new' => 'items#new'
  get 'messages' => 'items#show_messages'
  get 'manage_items' => 'items#manage_items'


  resources :conversations, only: [:create] do
    member do
      post :close
    end
    resources :messages, only: [:create]
  end

   resources :items do
    resources :bookings, only: [:create, :show, :update, :edit]
   end

   resources :charges
   
end
