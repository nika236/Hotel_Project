Rails.application.routes.draw do
  resources :hotels do
    resources :rooms, except: [:index] do
      resources :bookings, except: [:index]
    end
  end


  root 'pages#home'
  get '/about', to: 'pages#about'
end
