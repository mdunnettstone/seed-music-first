Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'users/registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'bookings#home'
  resources :facilities, only: [:new, :create]
  resources :room_timeslots, only: [:new, :create, :index, :update, :show]
  resources :rooms do
    resources :room_comments, only: :create
    resources :room_facilities, only: [:new, :create]
  end
  resources :users
  resources :bookings
  get "users/validation/check_email", :controller => "users", :action => "check_email"
end
