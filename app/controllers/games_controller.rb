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
    the_id = params[:bgg_id]

    gamerequest = HTTP.get("https://boardgamegeek.com/xmlapi2/thing?id=#{the_id}&type=boardgame,boardgameexpansion")
    response = Hash.from_xml(gamerequest).to_json
    data = JSON.parse(response)
    if data && data["items"] && data["items"]["item"]
      is_data = true
    else
      is_data = false
    end

    if gamerequest.code == 200 && is_data
      if data["items"]["item"]["name"][0]
        entry_game_name = data["items"]["item"]["name"][0]["value"]
      else
        entry_game_name = data["items"]["item"]["name"]["value"]
      end

      entry_game_type = data["items"]["item"]["type"]
      entry_image_url = data["items"]["item"]["image"]
      entry_release_year = data["items"]["item"]["yearpublished"]["value"]
      entry_description = data["items"]["item"]["description"]
      entry_bgg_id = data["items"]["item"]["id"]

      @game = Game.new(
        game_name: entry_game_name,
        game_type: entry_game_type, image_url: entry_image_url,
        release_year: entry_release_year,
        description: entry_description,
        bgg_id: entry_bgg_id,
      )
    end

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
