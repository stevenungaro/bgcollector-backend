Rails.application.routes.draw do
  get "/games" => "games#index"
  post "/games" => "games#create"
  get "/games/:id" => "games#show"
  patch "/games/:id" => "games#update"
  delete "/games/:id" => "games#destroy"

  get "/users" => "users#index"
  post "/users" => "users#create"
  get "/users/:id" => "users#show"
  patch "/users/:id" => "users#update"
  delete "/users/:id" => "users#destroy"

  get "/reviews" => "reviews#index"
  post "/reviews" => "reviews#create"
  get "/reviews/:game_id" => "reviews#show"
  patch "/reviews/:id" => "reviews#update"
  delete "/reviews/:id" => "reviews#destroy"

  get "/user_games" => "user_games#index"
  post "/user_games" => "user_games#create"
  get "/user_games/:username" => "user_games#show"
  patch "/user_games/:id" => "user_games#update"
  delete "/user_games/:id" => "user_games#destroy"

  post "/sessions" => "sessions#create"
end
