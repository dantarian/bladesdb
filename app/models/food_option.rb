class FoodOption < ApplicationRecord
    belongs_to :game
    belongs_to :food_category
    belongs_to :food_sub_category
  
    validates_presence_of :game_id
    validates_presence_of :food_category_id
    validates_presence_of :food_sub_category_id
    validates_presence_of :description
    
    auto_strip_attributes :description
end
