class Caterer < ApplicationRecord
    belongs_to :game
  
    validates_presence_of :game_id
    validates_presence_of :user_id
    
end
