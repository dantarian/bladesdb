class FoodOption < ActiveRecord::Base
    belongs_to :game
  
    validates_presence_of :game_id
    validates_presence_of :name
    
    auto_strip_attributes :name
end
