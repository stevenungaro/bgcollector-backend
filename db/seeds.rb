# Game Seeds
# # The algorithm below populates games using the BoardGameGeek database. It can only handle so many requests at a time.
# id_count = 187

# while id_count < 201
#   gamerequest = HTTP.get("https://boardgamegeek.com/xmlapi2/thing?id=#{id_count}&type=boardgame,boardgameexpansion")
#   response = Hash.from_xml(gamerequest).to_json
#   data = JSON.parse(response)
#   if data && data["items"] && data["items"]["item"]
#     is_data = true
#   else
#     is_data = false
#   end

#   if gamerequest.code == 200 && is_data
#     if data["items"]["item"]["name"][0]
#       entry_game_name = data["items"]["item"]["name"][0]["value"]
#     else
#       entry_game_name = data["items"]["item"]["name"]["value"]
#     end

#     entry_game_type = data["items"]["item"]["type"]
#     entry_image_url = data["items"]["item"]["image"]
#     entry_release_year = data["items"]["item"]["yearpublished"]["value"]
#     entry_description = data["items"]["item"]["description"]
#     entry_bgg_id = data["items"]["item"]["id"]

#     Game.create!(
#       game_name: entry_game_name,
#       game_type: entry_game_type, image_url: entry_image_url,
#       release_year: entry_release_year,
#       description: entry_description,
#       bgg_id: entry_bgg_id,
#     )
#   end
#   id_count += 1
# end

# User.create!(username: "plurpee", email: "plurpee@test.com", password: "password1")

# UserGame.create!(user_id: 1, game_id: 13)

# Review.create!(user_id: 1, game_id: 13, review_text: "This game is alright", thumb_down: 0, thumb_up: 1)
