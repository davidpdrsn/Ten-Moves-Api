Rails.application.routes.draw do
  resources :moves, only: [:index, :create]
  delete "delete_move_by_name", to: "moves#delete_move_by_name"

  get '/search', to: 'searches#show', as: :new_search
  get '/admin', to: 'admin#index', as: :admin

  root to: 'home#index'
end
