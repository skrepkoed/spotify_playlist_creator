Rails.application.routes.draw do
 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :playlists, only:[:new,:create,:index] do 

    collection do
      post 'albums', to: 'playlists#albums', as: 'artist' #, constraints: lambda{|request| }
      post 'songs' , to: 'playlists#songs', as: 'album'
     
    end

  end
  resources :users , only:[:edit, :show, :create, :destroy,:new]

  get '/sign in', to: 'session#new'
  get '/sign out', to: 'session#destroy'
  get '/sign up', to: 'users#new'
  post '/session', to: 'session#create'
  get '/tokens/new', to: 'tokens#new'
  get '/tokens/create',to: 'tokens#create'

  root to: 'pages#welcome'
end
