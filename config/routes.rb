Rails.application.routes.draw do
  root 'users#home'

  resources :users do
    resources :posts
  end

  get '/auth/twitter/callback', to: 'sessions#create'
  get '/auth/failure', to: redirect('/')
  get '/signout' => 'sessions#destroy', :as => :signout

end
