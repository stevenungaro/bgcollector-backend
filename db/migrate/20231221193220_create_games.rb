class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string :game_name
      t.string :image_url
      t.integer :release_year
      t.text :description
      t.integer :bgg_id

      t.timestamps
    end
  end
end
