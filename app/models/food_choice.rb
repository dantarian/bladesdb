class FoodChoice < ActiveRecord::Base
    belongs_to :game_attendance
  
    validates_presence_of :game_attendance_id
    validates_presence_of :food_option_id
    
end
