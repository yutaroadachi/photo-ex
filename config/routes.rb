Rails.application.routes.draw do
  root 'static_pages#home'
  get 'static_pages/home'
  
  devise_scope :user do
    get "sign_up",  :to => "users/registrations#new"
    get "sign_in",  :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy" 
  end
  
  devise_for :users, :controllers => {
    :registrations      => "users/registrations",
    :sessions           => "users/sessions",
    :omniauth_callbacks => "users/omniauth_callbacks" 
  }
end