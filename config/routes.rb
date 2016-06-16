Rails.application.routes.draw do

  root 'pages#index'
  get '/auth/fitbit_oauth2/callback', to: 'sessions#create'
  get "/auth/spotify/callback", to: "sessions#complete"
  get '/spotify_login', to: 'pages#spotify_login', as: 'spotify_login'
  get '/dashboard', to: 'pages#dashboard', as: 'dashboard'
  get '/index', to: 'pages#index', as: 'index'
  get '/logout', to: 'sessions#destroy', as: 'logout'
  post '/playlists', to: 'playlists#create'
  get '/playlists', to: 'playlists#index'
  post '/playlists/:id', to: 'playlists#populate', as: 'populate'
  delete '/playlists/:id', to: 'playlists#delete_track', as: 'track'

  resources :playlists, only: :show

  get 'populate' => 'playlists#populate'
  
end
