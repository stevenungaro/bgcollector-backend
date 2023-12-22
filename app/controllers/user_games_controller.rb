class UserGamesController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]

  def index
    @user_games = current_user.user_games
    render :index
  end

  def show
    @user_games = User.find_by(id: params[:id]).user_games
    render :show
  end

  def create
    @user_game = UserGame.new(
      user_id: current_user.id,
      game_id: params["game_id"],
    )
    @user_game.save
    if @user_game.valid?
      render :show
    else
      render json: { errors: @user_game.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @user_game = UserGame.find_by(id: params["id"])
    @user_game.update(
      user_id: current_user.id,
      game_id: params["game_id"] || @user_game.game_id,
    )
    if @user_game.valid?
      render :show
    else
      render json: { errors: @user_game.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    user_game = UserGame.find_by(id: params["id"])
    user_game.delete
    render json: { message: "Game removed from collection." }
  end
end
