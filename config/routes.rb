Rails.application.routes.draw do
  get 'static_pages/about'

  get 'static_pages/study'

  get 'static_pages/stats'

  get 'static_pages/profile'

  root 'users#home'

  resources :users do
    resources :posts
  end

  resources :events

  get '/auth/twitter/callback', to: 'sessions#create'
  get '/auth/failure', to: redirect('/')
  get '/signout' => 'sessions#destroy', :as => :signout

end
