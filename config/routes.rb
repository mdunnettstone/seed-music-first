Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'rooms#index'
  resources :rooms do
    resources :room_comments, only: :create
  end
  resources :users
end
