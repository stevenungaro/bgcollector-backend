class GamesController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]

  def index
    @games = Game.all
    render :index
  end

  def show
    @game = Game.find_by(id: params[:id])
    render :show
  end

  def create
    @game = Game.new(
      game_name: params["game_name"],
      image_url: params["image_url"],
      release_year: params["release_year"],
      description: params["description"],
      bgg_id: params["bgg_id"],
    )
    @game.save
    if @game.valid?
      render :show
    else
      render json: { errors: @game.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @game = Game.find_by(id: params["id"])
    @game.update(
      game_name: params["game_name"] || @game.game_name,
      image_url: params["image_url"] || @game.image_url,
      release_year: params["release_year"] || @game.release_year,
      description: params["description"] || @game.description,
      bgg_id: params["bgg_id"] || @game.bgg_id,
    )
    if @game.valid?
      render :show
    else
      render json: { errors: @game.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    game = Game.find_by(id: params["id"])
    game.delete
    render json: { message: "game successfully deleted" }
  end
end
