LocateMyStickers::Application.routes.draw do
  root :to => 'static_pages#home'

  match '/live_locations', :to => "locations#live_locations"
  match '/users/:id/empty_stickers_locations', :to => 'users#empty_stickers_locations'
  match '/users/:id/wa_show', :to => 'users#wa_show'
  resources :posts
  match '/users/create_user', :to => 'users#create_user'
  match '/users/delete_user', :to => 'users#delete_user'
  match '/users/admins', to: 'users#admins'
  match '/users/count', to: 'users#count'
  match '/users/:user_id/stickers/count', to: 'stickers#count'
  match '/users/:user_id/stickers/:sticker_id/locations/count', to: 'locations#count'
  match '/users/:user_id/stickers/:id/lastlocationaddress', to: 'stickers#last_location_address'

  resources :users do
    resources :conversations do
      resources :messages, :users
    end
    resources :messages, :histories
    resources :stickers do
      resources :histories, :locations
      resources :zones do
        resources :zone_locations
      end
      match '/minimap', to: 'stickers#minimap'
    end

    member do
      get :followed_stickers, :shared_stickers
      get :following, :followers
    end
  end

  resources :friendships,   only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :sessions,      only: [:new, :create, :destroy]
  resources :messages
  resources :histories

  match '/users/:id/updateddata',  to: 'users#updated_data'
  match '/users/:id/getstickers',  to: 'stickers#get_stickers'
  match '/users/:id/friends',  to: 'users#friends', only: [:index]
  match '/users/:id/add_friend',  to: 'users#add_friend'
  match '/users/:id/remove_friend',  to: 'users#remove_friend'
  match '/users/:id/is_friend',  to: 'users#is_friend'
  match '/users/:id/update_user', :to => 'users#update_user'
  match '/users/:id/statistics', :to => 'users#statistics'
  match '/users/:id/new_notifications', :to => 'users#new_notifications'
  match '/users/:id/old_notifications', :to => 'users#old_notifications'

  match '/histories/:id/confirm', :to => 'histories#confirm'

  match '/update_sticker', :to => 'stickers#update'
  match '/delete_sticker', :to => 'stickers#destroy'
  match '/create_message', :to => 'messages#create_message'

  match '/stickers/:id/possessor', :to => 'stickers#possessor'

  match '/signup',  to: 'users#new'
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy'#, via: :delete

  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'
  match '/stats', to: 'static_pages#stats'
  match '/news', to: 'posts#news'

  match '/admin/developer_guide', to: 'administration#developer_guide'
  match '/admin/launch_simulation', to: 'administration#launch_simulation'
  match '/admin/simulator', to: 'administration#simulator'
  match '/admin', to: 'administration#admin'

  match '/friendships', to: 'friendships#destroy', via: :delete
  match '/stickers', to: 'stickers#all_stickers'
  match '/locations', to: 'locations#all_locations'
  match '/conversations', to: 'conversations#all_conversations'
  match '/zones', to: 'zones#all_zones'
  
end

