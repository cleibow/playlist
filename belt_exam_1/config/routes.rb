Rails.application.routes.draw do
  get 'main' => "application#index", as: "main"
  get 'songs/:song_id' => "songs#show", as: "playlist"
  get 'like/:id' => "likes#create", as: "like"
  delete 'like/:id' => "likes#destroy", as: "unlike"

  resources :songs, only: [:create, :index]
  resources :users, except: [:index]
  resources :sessions, only: [:new, :create, :destroy]
  resources :likes, only: [:create]

end


#    songs GET    /songs(.:format)          songs#index
#          POST   /songs(.:format)          songs#create
#    users POST   /users(.:format)          users#create
# new_user GET    /users/new(.:format)      users#new
# edit_user GET    /users/:id/edit(.:format) users#edit
#     user GET    /users/:id(.:format)      users#show
#          PATCH  /users/:id(.:format)      users#update
#          PUT    /users/:id(.:format)      users#update
#          DELETE /users/:id(.:format)      users#destroy
# sessions POST   /sessions(.:format)       sessions#create
# new_session GET    /sessions/new(.:format)   sessions#new
#  session DELETE /sessions/:id(.:format)   sessions#destroy