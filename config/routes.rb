Rails.application.routes.draw do
  resources :hotels
  root 'pages#home'
  get '/about', to: 'pages#about'
end
