# README

# <BG-Collector-Backend>

BG Collector is an API designed to be used for users to view descriptions of board games, track their collection, and add and view user reviews. It seeds data from the Board Game Geek API and handles converting their xml to more legible JSON, pulling down the game title, year released, image url, and description.

I wanted to build this to create a more minimalist website than BoardGameGeek. That website has a lot of information that I am less interested in and I also wanted the ability to add custom tags for easier searching and customized lists.

This was built using Ruby on Rails. Additional gems added are jwt, bcrypt, http, and rack-cors for front end access and signup/login management.

## Installation

```bash
bundle install
rails db:create db:migrate
```

Prior to seeding, uncomment the code in the seeds files. Then change the parameters of the Game create while loop. If you set id_count to 1, it will start pulling games from Board Game Geek at id 1. The while loop will continue running unti an id of your choosing. Please note that the BGG database currently contains over 400,000 items in it. For testing and budiling your database, we recommend pulling a few dozen. The loop also has a "sleep 2" line to reduce overload on the BGG API. This will make this code move somewhat slow for very large pulls but is necessary for preventing skipping games in the BGG database.

Once id_count and the while loop parameter have been set:

```bash
rails db:seed
```

## Usage

```bash
rails server
```

Check your browser at http://localhost:3000. Current available routes includes are below. You must create a sessions with a jwt before logging in:

```bash

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
```

## Tests

There aren't currently any tests, but if there were...

You can run all the API tests from the `test` folder by running:

```bash
rails test
```

## Roadmap

The main idea for the future is creating an additional table of "tags" that pulls downs all the information from the BGG API such as category, mechanic, family, designer, publisher, etc. and also allows users to create custom tags. A front end could then use these tags to allow custom searches, list creation, etc.
