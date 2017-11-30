# As per https://github.com/ryanb/railscasts-episodes/issues/12
require 'no_subdomain'
require 'has_subdomain'
Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  constraints(NoSubdomain) do
    root 'static_pages#home'
    get "/unis", :controller => "static_pages", :action => "unis"
    get "/download_uni_doc", :controller => "static_pages", :action => "download_uni_doc"
  end

  constraints(HasSubdomain) do
    devise_for :users, :controllers => { registrations: 'users/registrations' }
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
      resources :whitelisted_emails, only: [:index, :create]
    end
    resources :users
    resources :bookings, except: [:index] do
      member do
        patch :add_user
        put :add_user
        patch :remove_user
        put :remove_user
      end
    end
    get "/home", :controller => "bookings", :action => "home"
    get "users/validation/check_email", :controller => "users", :action => "check_email"
  end
  require 'sidekiq/web'
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
