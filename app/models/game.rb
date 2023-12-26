class Game < ApplicationRecord
  has_many :user_games
  has_many :reviews

  validates :bgg_id, presence: true, uniqueness: true
end
