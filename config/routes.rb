Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'users/registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'bookings#home'
  resources :room_timeslots, only: [:new, :create, :index, :update, :show]
  resources :rooms do
    resources :room_comments, only: :create
  end
  resources :users
  get '/bookings/confirmation/:id', to: 'bookings#confirmation', as: 'booking_confirmation'
  resources :bookings, only: [:new, :create]
end
