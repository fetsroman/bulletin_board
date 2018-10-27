Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  resources :users
  resources :adverts do
  	resources :comments
  end
  root 'adverts#index'
end
