Rails.application.routes.draw do
  resources :moves, only: [:index, :create]
  delete "delete_move_by_name", to: "moves#delete_move_by_name"
end
