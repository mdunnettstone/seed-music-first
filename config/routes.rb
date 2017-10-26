Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'users/registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'

  resources :rooms, only: [:show, :index] do
    resources :room_comments, only: :create
  end
  resources :feedbacks, only: [:new, :create]
  resources :posts, except: [:new]
  resources :post_replies, only: [:create]
  namespace :admin do
    resources :rooms, only: [:new, :create, :edit, :update] do
      resources :room_facilities, only: [:new, :create]
    end
    resources :facilities, only: [:new, :create]
    resources :bookings, only: [:index]
    get "/dashboard", :controller => "static_pages", :action => "dashboard"
    resources :room_comments, only: [:index]
  end
  resources :users
  resources :bookings, except: [:index]
  get "/home", :controller => "bookings", :action => "home"
  get "users/validation/check_email", :controller => "users", :action => "check_email"
  
end
