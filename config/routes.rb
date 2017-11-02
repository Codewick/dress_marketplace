Rails.application.routes.draw do
  resources :items
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
# get '/' => 'items#index'
root :to => 'items#index'
get 'items/new' => 'items#new'
end
