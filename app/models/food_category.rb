class FoodCategory < ApplicationRecord
    has_many :food_option
  
    validates_presence_of :description
    
    auto_strip_attributes :description
end
