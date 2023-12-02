Rails.application.routes.draw do
  resources :hotels
  resources :bookings, except: [:new, :create]
  resources :rooms do
    resources :bookings, only: [:new, :create]
  end
  root 'pages#home'
  get '/about', to: 'pages#about'
end
