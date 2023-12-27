class AddUniqueIndexToUserGames < ActiveRecord::Migration[7.0]
  def change
    add_index :user_games, [:user_id, :game_id], unique: true
  end
end
