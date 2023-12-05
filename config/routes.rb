Rails.application.routes.draw do
  root 'pages#home'
  get '/about', to: 'pages#about'

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }


  resources :hotels do
    resources :rooms, except: [:index] do
      resources :bookings, except: [:index, :edit, :update]
    end
  end

end
